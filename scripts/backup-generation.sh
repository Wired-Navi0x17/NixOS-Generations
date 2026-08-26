#!/usr/bin/env bash
set -e

REPO_DIR="/home/l41n-pr0t0/Workspace/Github/NixOS-Generations"
cd "$REPO_DIR"

GEN_PROFILE=$(readlink -f /nix/var/nix/profiles/system)
GEN_NUM=$(echo "$GEN_PROFILE" | grep -o 'system-[0-9]\+-link' | grep -o '[0-9]\+' || echo "current")
DATE_STR=$(date +"%Y-%m-%d %H:%M:%S")
KERNEL_VER=$(uname -r)

echo "=== Backing up NixOS Generation ${GEN_NUM} ==="

mkdir -p "$REPO_DIR/current" "$REPO_DIR/generations/gen-${GEN_NUM}" "$REPO_DIR/docs"

# 1. Update current config
cp -r /etc/nixos/configuration.nix /etc/nixos/hardware-configuration.nix /etc/nixos/limine-sync.sh "$REPO_DIR/current/"
if [ -d "/etc/nixos/pkgs" ]; then
  cp -r /etc/nixos/pkgs "$REPO_DIR/current/"
fi

# 2. Snapshot into generation directory
cp -r "$REPO_DIR/current"/* "$REPO_DIR/generations/gen-${GEN_NUM}/"

# 3. Create generation changelog if missing
CHANGELOG_FILE="$REPO_DIR/generations/gen-${GEN_NUM}/CHANGELOG.md"
if [ ! -f "$CHANGELOG_FILE" ]; then
  cat << CL_EOF > "$CHANGELOG_FILE"
# Generation ${GEN_NUM} Changelog

- **Date**: ${DATE_STR}
- **Kernel**: ${KERNEL_VER}
- **System Path**: \`${GEN_PROFILE}\`

## Summary of Changes:
- System rebuild snapshot captured on ${DATE_STR}.
CL_EOF
fi

# 4. Sync Documentation
if [ -d "/home/l41n-pr0t0/Downloads/Documentation" ]; then
  cp -r /home/l41n-pr0t0/Downloads/Documentation/* "$REPO_DIR/docs/"
fi

# 5. Git Stage & Commit
git add .
if git diff --staged --quiet; then
  echo "No configuration changes detected for Generation ${GEN_NUM}."
else
  git commit -m "chore(generation): snapshot NixOS Generation ${GEN_NUM} [${DATE_STR}]"
  echo "Committed Generation ${GEN_NUM} snapshot to git."
fi
