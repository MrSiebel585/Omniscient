.

---

# Omniscient – Digital Forensics & AI Framework

## Overview

**Omniscient** is a modular AI-driven **digital forensics and OSINT framework** designed to streamline investigation, logging, automation, and advanced analysis.
It integrates modern AI pipelines (Ollama, Hugging Face, LangChain, GPT4All) with traditional forensic workflows, enabling automated insights, reproducibility, and extensibility.

Key focus areas:

* Digital forensics automation (logs, OSINT, disk, and memory analysis).
* AI pipelines for summarization, anomaly detection, and automated reporting.
* Modular structure for integration with scripts, dashboards, and DevOps.
* Built for scalability: from personal research to enterprise-level deployment.

---

## Features

* 🔍 **Digital Forensics Assistant** – AI-assisted analysis of system logs, disk images, and network captures.
* 🤖 **AI Pipelines** – Integration with Hugging Face, Ollama, GPT4All, LangChain for automated log triage, anomaly detection, and reporting.
* 📊 **Dashboards & Visualization** – Planned UI/UX (Streamlit, Flask, Taipy) for visual forensic workflows.
* 🛠 **Script Library** – Modular tools for automation, system monitoring, and investigation tasks.
* 📦 **Installers & Binaries** – Easy deployment with pre-built installers and setup scripts.
* 🔐 **Security & Logging** – Audit-friendly logs, customizable retention policies, and compliance readiness.

---

## Installation

### Requirements

* **Python 3.10+**
* **pip**
* Recommended: Linux (Ubuntu/Debian), though cross-platform support is in progress.

### Quick Start

```bash
# Clone the repository
git clone https://github.com/MrSiebel585/Omniscient.git
cd Omniscient

# Create a virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Run the core system
python3 omniscient_main.py
```

---

## Usage

### Running the Framework

```bash
python3 omniscient_main.py
```

### Example Pipelines

* **Log Summarization**

  ```bash
  python3 tools/syslog_to_ai.py /var/log/syslog
  ```
* **OSINT Recon**

  ```bash
  python3 tools/osint_query.py --target "example.com"
  ```

### Web Dashboard (Planned)

```bash
streamlit run dashboards/main.py
```

---

## Project Structure

```
Omniscient/
│── ai/               # AI-driven scripts & pipelines
│── bin/              # Executable scripts & installers
│── config/           # Configuration files
│── logs/             # Internal logs
│── osint/            # OSINT & recon modules
│── forensics/        # Digital forensics utilities
│── scripts/          # User/system scripts
│── web/              # Web dashboard & templates
│── omniscient_main.py  # Core entrypoint
│── requirements.txt
│── README.md
```

---

## Roadmap

* ✅ Basic AI log summarizer (syslog, MySQL logs).
* ✅ Bash installer scripts for deployment.
* 🔄 Ongoing: Modular command-line interface (`omniscientctl`).
* 🖥 Planned: Streamlit/Taipy dashboards for live OSINT & forensic workflows.
* 🔒 Planned: Role-based access control (RBAC) for secure deployments.
* ☁️ Future: SaaS-ready forensic dashboard for enterprise clients.

---

## Contributing

We welcome contributions!

1. Fork the repository
2. Create a new branch: `git checkout -b feature/my-feature`
3. Commit changes: `git commit -m "Add my feature"`
4. Push to branch: `git push origin feature/my-feature`
5. Create a Pull Request

---

## License

[MIT License](LICENSE) – Open source, with commercial add-on options planned.

---

## Acknowledgments

* Hugging Face
* LangChain
* GPT4All
* Ollama

---

⚡ **Next Step**: You could also create a `/docs/` folder with extended guides:

* **docs/installation.md** – Advanced install options
* **docs/usage.md** – Detailed usage examples
* **docs/developer\_guide.md** – How to extend Omniscient
* **docs/roadmap.md** – Milestones & future features

---

Do you want me to **expand this into a full `/docs/` folder** with multiple files (installation, usage, developer guide, roadmap), or keep it lean with just the README for now?
