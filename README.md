# Nonuniformity Manuscript

Analysis notebook and reproducible environment for the nonuniformity manuscript project.

**Repository:** https://github.com/AbhiRbio/Nonuniformity_manuscript

## What's in this repo

- `Nonuniformity manuscript.ipynb` — the analysis notebook
- `requirements.txt` — Python dependencies (the recipe for the virtual environment)
- `.gitignore` — excludes the virtual environment, Jupyter checkpoints, caches, and OS files
- `.gitattributes` — registers the `nbstripout` filter so notebook outputs are stripped on commit

> **Note:** the virtual environment (`venv/`) is intentionally **not** tracked. It is rebuilt locally from `requirements.txt` on each machine.

---

## Setting up on a new machine

### 1. Prerequisites

Make sure these are installed (check each with the commands below):

- **git** — https://git-scm.com/downloads
- **Python 3** — https://www.python.org/downloads (on Windows, tick "Add Python to PATH" during install)
- **GitHub CLI (`gh`)** — optional but recommended; simplifies cloning and authentication — https://cli.github.com

```bash
git --version
python --version
gh --version
```

### 2. Clone the repo

Navigate to wherever you want the project to live, then:

```bash
git clone https://github.com/AbhiRbio/Nonuniformity_manuscript.git
cd Nonuniformity_manuscript
```

(Or with the CLI: `gh repo clone AbhiRbio/Nonuniformity_manuscript`.)

This pulls down everything tracked in the repo — the notebook, `requirements.txt`, `.gitignore`, `.gitattributes` — but **not** the venv, which is rebuilt next.

### 3. Rebuild the virtual environment

```bash
python -m venv venv
```

Activate it:

- **macOS / Linux:** `source venv/bin/activate`
- **Windows (PowerShell):** `.\venv\Scripts\Activate.ps1`

Your prompt should now show `(venv)`. Then install dependencies:

```bash
python -m pip install --upgrade pip
pip install -r requirements.txt
```

`nbstripout` is listed in `requirements.txt`, so it installs automatically here.

### 4. Activate the nbstripout filter (once per machine)

The `.gitattributes` rule is already in the repo, but the filter itself lives in each machine's local `.git/config` and must be registered separately:

```bash
nbstripout --install
```

Without this step, this machine would commit notebooks **with** their outputs and reintroduce noisy diffs.

### 5. Set identity and credentials

If this machine has your own user account:

```bash
git config --global user.name "Abhishek"
git config --global user.email "your-github-email@example.com"
```

If it's a **shared login**, scope the identity to this repo only:

```bash
git config --local user.name "Abhishek"
git config --local user.email "your-github-email@example.com"
```

Then authenticate for pushing via `gh auth login` or a Personal Access Token.

The machine is now a full mirror and ready to work.

---

## Daily workflow (coordinating multiple machines)

Treat the remote (GitHub) as the **single source of truth**. The local machines are temporary workspaces. Pull before you start, push before you walk away.

### Start of every session — pull first

```bash
git pull
```

Also activate the venv: `source venv/bin/activate` (macOS/Linux) or `.\venv\Scripts\Activate.ps1` (Windows).

### End of every session — commit and push

```bash
git add -A
git commit -m "describe what you changed"
git push
```

**Do not switch machines until the push succeeds.** Leaving unpushed work on one machine and then editing on another is the most common way this workflow breaks.

### When you add or upgrade a package

A two-part update — install it **and** record it:

```bash
pip install <package>
pip freeze | grep -i <package> >> requirements.txt
git add requirements.txt
git commit -m "Add <package> to requirements"
git push
```

Then on the other machine, after `git pull`, re-sync the environment:

```bash
pip install -r requirements.txt
```

Pulling updates the recipe; it does not reinstall automatically.

### If a push is rejected

It means the remote has changes this machine doesn't have yet:

```bash
git pull
git push
```

Resolve any merge conflicts by hand. `nbstripout` keeps notebook output cells out of diffs, which avoids most notebook conflicts.

### Golden rule

Don't edit the same notebook on two machines without pushing in between. One person on two machines is easy precisely because you can serialize your own work — finish and push on one before starting on the other.
