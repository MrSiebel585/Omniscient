#!/usr/bin/env python3
"""
omnidevchat.py - REPL AI Agent for Omniscient System Development (Ollama version)
Location: /opt/omniscient/ai/omnidevchat.py
Usage: Run `omnidevchat` to enter the chat.
"""

import ollama, json, os, datetime, subprocess

HISTORY_FILE = "/opt/omniscient/ai/.dev_context.json"
LOG_FILE = "/opt/omniscient/logs/dev_repl.log"
MODEL = "llama3"  # Change to any installed Ollama model, e.g. "codellama", "mistral", etc.

def load_context():
    if os.path.exists(HISTORY_FILE):
        with open(HISTORY_FILE) as f:
            return json.load(f)
    # Initial system prompt
    return {
        "messages": [
            {
                "role": "system",
                "content": (
                    "You are the AI lead developer for the Omniscient framework. "
                    "Your job is to suggest, create, and improve scripts, modules, "
                    "pipelines, and integration tasks. Give direct code if asked."
                )
            }
        ]
    }

def save_context(ctx):
    with open(HISTORY_FILE, "w") as f:
        json.dump(ctx, f, indent=2)

def log_to_file(prompt, response):
    with open(LOG_FILE, "a") as f:
        now = datetime.datetime.now().isoformat()
        f.write(f"\n[{now}] User: {prompt}\nAI: {response}\n")

def chat(prompt, context):
    context["messages"].append({"role": "user", "content": prompt})

    # Ollama chat call
    res = ollama.chat(
        model=MODEL,
        messages=context["messages"],
        options={"temperature": 0.3},
    )
    reply = res['message']['content']

    context["messages"].append({"role": "assistant", "content": reply})
    log_to_file(prompt, reply)
    save_context(context)
    return reply

def run_shell(code):
    try:
        output = subprocess.check_output(
            code, shell=True, stderr=subprocess.STDOUT, text=True
        )
        return output
    except subprocess.CalledProcessError as e:
        return f"Error: {e.output}"

def main():
    ctx = load_context()
    print("🧠 OmnidevChat — Omniscient AI Developer Console (Ollama)")
    while True:
        try:
            user_input = input("dev> ").strip()
            if not user_input:
                continue
            elif user_input.lower() in ("exit", "quit"):
                break
            elif user_input.startswith("!run"):
                code = user_input[4:].strip()
                print(run_shell(code))
            else:
                reply = chat(user_input, ctx)
                print(f"\n{reply}\n")
        except KeyboardInterrupt:
            break

if __name__ == "__main__":
    main()
