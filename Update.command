#!/bin/bash
if [ -z "$TERM" ]; then exec /Applications/Utilities/Terminal.app/Contents/MacOS/Terminal "$0" & exit 0; fi
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"
if ! command -v git >/dev/null 2>&1; then echo "git not found"; exit 1; fi
[ -d ".git" ] || git init
if ! git remote get-url origin >/dev/null 2>&1; then git remote add origin https://github.com/SHAMONTEK/ACTORS.git; fi
git checkout -B main >/dev/null 2>&1 || true
[ -f ".gitignore" ] || echo ".DS_Store" > .gitignore
git add -A
if ! git diff --cached --quiet; then git commit -m "update: $(date '+%Y-%m-%d %H:%M:%S')"; fi
git push -u origin main || true
osascript -e 'display notification "ACTORS synced to GitHub." with title "Git Push"'
read -p "Press Enter to close…"
