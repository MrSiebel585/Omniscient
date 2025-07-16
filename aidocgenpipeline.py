#!/usr/bin/env python3 """ ai_doc_pipeline.py Location: /opt/omniscient/ai/ Purpose: AI-powered documentation tool to convert Markdown documentation into manpages and summaries for intuitive system usage. Usage: python3 ai_doc_pipeline.py --manpages python3 ai_doc_pipeline.py --summarize python3 ai_doc_pipeline.py --inject python3 ai_doc_pipeline.py --speak """

import os import argparse from pathlib import Path import openai import markdown2

MANPAGE_DIR = Path("/opt/omniscient/manpages") README_DIR = Path("/opt/omniscient/readme") LOGFILE = Path("/opt/omniscient/logs/ai_doc_pipeline.log") openai.api_key = os.getenv("OPENAI_API_KEY")  # Ensure this is exported

def generate_manpage(markdown_content, filename): response = openai.ChatCompletion.create( model="gpt-4", messages=[ {"role": "system", "content": "Convert the following Markdown into a Linux manpage."}, {"role": "user", "content": markdown_content}, ] ) man_text = response.choices[0].message['content'] man_file = MANPAGE_DIR / f"{filename}.1" with open(man_file, "w") as f: f.write(man_text) print(f"✅ Manpage generated: {man_file}")

def summarize_doc(markdown_content, filename): response = openai.ChatCompletion.create( model="gpt-4", messages=[ {"role": "system", "content": "Summarize the following Markdown doc in plain English for CLI users."}, {"role": "user", "content": markdown_content}, ] ) summary = response.choices[0].message['content'] print(f"\n📘 Summary for {filename}:\n{summary}\n")

def speak(text): from subprocess import run output_file = "/tmp/omniscient_voice_doc.mp3" speech = openai.audio.speech.create( model="tts-1", voice="onyx", input=text ) speech.stream_to_file(output_file) run(["mpg123", output_file])

def main(): parser = argparse.ArgumentParser() parser.add_argument("--manpages", action="store_true", help="Generate manpages from markdown") parser.add_argument("--summarize", action="store_true", help="Summarize each doc") parser.add_argument("--speak", action="store_true", help="Speak each summary out loud") args = parser.parse_args()

os.makedirs(MANPAGE_DIR, exist_ok=True)

for md_file in README_DIR.glob("*.md"):
    with open(md_file, "r") as f:
        content = f.read()
    filename = md_file.stem

    if args.summarize:
        summary = summarize_doc(content, filename)
        if args.speak:
            speak(summary)

    if args.manpages:
        generate_manpage(content, filename)

if name == "main": main()

