# ...existing code...
#!/usr/bin/env python3
"""
ai_doc_pipeline.py
Location: /opt/omniscient/ai/
Purpose: AI-powered documentation tool to convert Markdown documentation into manpages and summaries.
"""

import os
import argparse
import logging
import shutil
import subprocess
from pathlib import Path
from typing import Optional

try:
    import openai
except Exception:
    openai = None

try:
    import markdown2  # optional
except Exception:
    markdown2 = None

MANPAGE_DIR = Path("/opt/omniscient/manpages")
README_DIR = Path("/opt/omniscient/readme")
LOGFILE = Path("/opt/omniscient/logs/ai_doc_pipeline.log")

# Ensure log directory exists
LOGFILE.parent.mkdir(parents=True, exist_ok=True)
logging.basicConfig(
    filename=str(LOGFILE),
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(message)s",
)

OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")
if openai and OPENAI_API_KEY:
    try:
        openai.api_key = OPENAI_API_KEY
    except Exception:
        logging.warning("Failed to set openai.api_key, continuing without AI backend.")

def log_action(message: str) -> None:
    logging.info(message)

def _safe_openai_chat(system_prompt: str, user_content: str) -> Optional[str]:
    """
    Try several access patterns for OpenAI chat completions to be resilient
    across SDK versions. Returns text or None on failure.
    """
    if not openai or not OPENAI_API_KEY:
        logging.debug("OpenAI or API key not available, skipping AI call.")
        return None

    try:
        # Preferred pattern (classic)
        resp = openai.ChatCompletion.create(
            model="gpt-4",
            messages=[
                {"role": "system", "content": system_prompt},
                {"role": "user", "content": user_content},
            ],
            temperature=0.2,
        )
        # handle object or dict-style responses
        if hasattr(resp, "choices"):
            choice = resp.choices[0]
            # some SDKs use .message.content
            if hasattr(choice, "message") and isinstance(choice.message, dict):
                return choice.message.get("content")
            if hasattr(choice, "message") and hasattr(choice.message, "get"):
                return choice.message.get("content")
            if hasattr(choice, "message") and hasattr(choice.message, "content"):
                return choice.message.content
            # fallback to dict access
            return resp["choices"][0]["message"]["content"]
    except Exception as e:
        logging.warning(f"ChatCompletion.create failed: {e}")

    # try newer API patterns if present
    try:
        resp = openai.chat.completions.create(
            model="gpt-4",
            messages=[
                {"role": "system", "content": system_prompt},
                {"role": "user", "content": user_content},
            ],
            temperature=0.2,
        )
        return resp.choices[0].message["content"]
    except Exception as e:
        logging.warning(f"openai.chat.completions.create failed: {e}")

    logging.error("All OpenAI chat attempts failed.")
    return None

def _pandoc_to_man(markdown_content: str, out_path: Path) -> bool:
    """
    Use pandoc if installed to generate a manpage. Returns True on success.
    """
    pandoc = shutil.which("pandoc")
    if not pandoc:
        return False
    try:
        tmp_md = out_path.with_suffix(".md.tmp")
        tmp_md.write_text(markdown_content, encoding="utf-8")
        completed = subprocess.run(
            [pandoc, "-s", "-t", "man", "-o", str(out_path), str(tmp_md)],
            check=False,
            capture_output=True,
        )
        tmp_md.unlink(missing_ok=True)
        if completed.returncode == 0 and out_path.exists():
            return True
        logging.warning(f"pandoc failed: {completed.returncode} {completed.stderr.decode(errors='ignore')}")
    except Exception as e:
        logging.exception(f"pandoc conversion error: {e}")
    return False

def generate_manpage(markdown_content: str, filename: str) -> Optional[Path]:
    """
    Generate a manpage for the given markdown_content.
    Tries pandoc first, then falls back to OpenAI chat conversion if available.
    Returns path to generated manpage or None.
    """
    MANPAGE_DIR.mkdir(parents=True, exist_ok=True)
    man_file = MANPAGE_DIR / f"{filename}.1"

    # Try pandoc local conversion first
    if _pandoc_to_man(markdown_content, man_file):
        log_action(f"Manpage generated via pandoc: {man_file}")
        return man_file

    # Fallback to OpenAI conversion
    system_prompt = "Convert the following Markdown into a Linux manpage (troff man format). Keep sections, synopsis, options."
    ai_out = _safe_openai_chat(system_prompt, markdown_content)
    if ai_out:
        try:
            man_file.write_text(ai_out, encoding="utf-8")
            log_action(f"Manpage generated via OpenAI: {man_file}")
            return man_file
        except Exception as e:
            logging.exception(f"Failed to write manpage file {man_file}: {e}")
            return None

    logging.error("Failed to generate manpage (no pandoc, no AI).")
    return None

def inject_summary_into_markdown(markdown_content: str, summary: str) -> str:
    # Injects summary at the top of the markdown file as an HTML comment
    return f"<!-- AI Summary: {summary} -->\n\n{markdown_content}"

def summarize_doc(markdown_content: str, filename: str) -> Optional[str]:
    """
    Summarize the Markdown content in plain English for CLI users.
    Returns the summary string or None.
    """
    system_prompt = "Summarize the following Markdown doc in plain English for CLI users. Provide a short bullet list of key commands and purpose."
    ai_out = _safe_openai_chat(system_prompt, markdown_content)
    if ai_out:
        log_action(f"Summarized {filename}")
        return ai_out.strip()
    logging.warning(f"No summary produced for {filename}.")
    return None

def speak(text: str) -> None:
    """
    Speak text using local TTS (espeak fallback). Does not require OpenAI.
    """
    if not text:
        return
    espeak = shutil.which("espeak")
    if espeak:
        try:
            subprocess.run([espeak, text], check=False)
            log_action("Spoken via espeak.")
            return
        except Exception as e:
            logging.exception(f"espeak failed: {e}")

    # last-resort: try writing to a temp mp3 via OpenAI TTS if available
    if openai and OPENAI_API_KEY:
        try:
            # Attempt to use older TTS API shape; may need adjusting for your SDK
            if hasattr(openai, "audio") and hasattr(openai.audio, "speech"):
                out_file = "/tmp/omniscient_voice_doc.mp3"
                try:
                    resp = openai.audio.speech.create(model="tts-1", voice="onyx", input=text)
                    # older SDKs may provide .stream_to_file, newer may not
                    if hasattr(resp, "stream_to_file"):
                        resp.stream_to_file(out_file)
                    else:
                        # attempt to write binary content if present
                        content = getattr(resp, "content", None) or getattr(resp, "audio", None)
                        if isinstance(content, (bytes, bytearray)):
                            Path(out_file).write_bytes(content)
                    mpg = shutil.which("mpg123") or shutil.which("mpg321")
                    if mpg:
                        subprocess.run([mpg, out_file], check=False)
                        log_action("Spoken via OpenAI TTS (mpg).")
                        return
                except Exception as e:
                    logging.warning(f"OpenAI TTS attempt failed: {e}")
    logging.warning("No TTS provider available; skipping speak().")

def process_docs(args: argparse.Namespace) -> None:
    MANPAGE_DIR.mkdir(parents=True, exist_ok=True)
    if not README_DIR.exists():
        logging.error(f"Readme directory {README_DIR} does not exist.")
        return

    for md_file in sorted(README_DIR.glob("*.md")):
        try:
            content = md_file.read_text(encoding="utf-8")
        except Exception as e:
            logging.exception(f"Failed to read {md_file}: {e}")
            continue
        filename = md_file.stem

        summary = None
        if args.summarize:
            summary = summarize_doc(content, filename)
            if summary:
                log_action(f"Summarized {md_file}")
                print(f"\n📘 Summary for {filename}:\n{summary}\n")
                if args.speak:
                    speak(summary)
                    log_action(f"Spoken summary for {md_file}")

        if args.manpages:
            man_path = generate_manpage(content, filename)
            if man_path:
                print(f"✅ Manpage generated: {man_path}")
                log_action(f"Generated manpage for {md_file}")

        if getattr(args, "inject", False) and summary:
            try:
                new_content = inject_summary_into_markdown(content, summary)
                md_file.write_text(new_content, encoding="utf-8")
                log_action(f"Injected summary into {md_file}")
            except Exception as e:
                logging.exception(f"Failed to inject summary into {md_file}: {e}")

def main() -> None:
    parser = argparse.ArgumentParser(description="AI doc pipeline: manpages, summaries, injection, TTS.")
    parser.add_argument("--manpages", action="store_true", help="Generate manpages from markdown")
    parser.add_argument("--summarize", action="store_true", help="Summarize each doc")
    parser.add_argument("--speak", action="store_true", help="Speak each summary out loud (uses espeak or OpenAI TTS)")
    parser.add_argument("--inject", action="store_true", help="Inject AI summary into each markdown file as a comment")
    args = parser.parse_args()

    try:
        process_docs(args)
    except Exception as e:
        logging.exception(f"Unhandled error in main: {e}")
        parser.exit(1)

if __name__ == "__main__":
    main()
# ...existing code...
