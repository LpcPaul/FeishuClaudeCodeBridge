#!/usr/bin/env bash
set -euo pipefail

REPO_TARBALL_URL="${FEISHU_CLAUDE_CODE_BRIDGE_TARBALL_URL:-https://github.com/LpcPaul/FeishuClaudeCodeBridge/archive/refs/heads/main.tar.gz}"
TMP_DIR="$(mktemp -d)"
cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

curl -fsSL "$REPO_TARBALL_URL" | tar -xz -C "$TMP_DIR"
PROJECT_DIR="$(find "$TMP_DIR" -maxdepth 1 -type d -name 'FeishuClaudeCodeBridge-*' | head -n 1)"

if [[ -z "$PROJECT_DIR" ]]; then
  echo "Failed to unpack FeishuClaudeCodeBridge." >&2
  exit 1
fi

cd "$PROJECT_DIR"
exec ./install.sh
