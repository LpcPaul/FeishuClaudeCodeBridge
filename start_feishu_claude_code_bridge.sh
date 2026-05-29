#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_RUNTIME_DIR="${HOME}/Library/Application Support/FeishuClaudeCodeBridge"
FEISHU_ENV_FILE="${FEISHU_ENV_FILE:-${PROJECT_DIR}/.env.feishu}"

cd "$PROJECT_DIR"

if [[ ! -f "$FEISHU_ENV_FILE" ]]; then
  echo "Missing Feishu env file: $FEISHU_ENV_FILE" >&2
  exit 1
fi

set -a
source "$FEISHU_ENV_FILE"
set +a

detect_nvm_file() {
  local pattern="$1"
  local result=""
  result="$(ls -1d $pattern 2>/dev/null | sort | tail -n 1 || true)"
  printf '%s' "$result"
}

export FEISHU_CLAUDE_CODE_WORKDIR="${FEISHU_CLAUDE_CODE_WORKDIR:-${HOME}}"
export FEISHU_CLAUDE_CODE_RUNTIME_DIR="${FEISHU_CLAUDE_CODE_RUNTIME_DIR:-${DEFAULT_RUNTIME_DIR}}"
export FEISHU_TOPIC_IDLE_SECONDS="${FEISHU_TOPIC_IDLE_SECONDS:-7200}"
export FEISHU_TOPIC_NOTICE_ENABLED="${FEISHU_TOPIC_NOTICE_ENABLED:-1}"
export FEISHU_TASK_PROGRESS_SECONDS="${FEISHU_TASK_PROGRESS_SECONDS:-7200}"
export NODE_BIN="${NODE_BIN:-$(command -v node || detect_nvm_file "${HOME}/.nvm/versions/node/*/bin/node")}"
export CLAUDE_BIN="${CLAUDE_BIN:-$(command -v claude || detect_nvm_file "${HOME}/.nvm/versions/node/*/bin/claude")}"
export CLAUDE_PERMISSION_MODE="${CLAUDE_PERMISSION_MODE:-auto}"
export CLAUDE_MODEL="${CLAUDE_MODEL:-}"
export CLAUDE_EFFORT="${CLAUDE_EFFORT:-}"
export CLAUDE_MAX_BUDGET_USD="${CLAUDE_MAX_BUDGET_USD:-}"
export CLAUDE_ALLOWED_TOOLS="${CLAUDE_ALLOWED_TOOLS:-}"
export CLAUDE_DISALLOWED_TOOLS="${CLAUDE_DISALLOWED_TOOLS:-}"
export CLAUDE_EXTRA_ARGS="${CLAUDE_EXTRA_ARGS:-}"
export PYTHON_BIN="${PYTHON_BIN:-$(detect_nvm_file "/Library/Frameworks/Python.framework/Versions/*/bin/python3")}"
export PYTHON_BIN="${PYTHON_BIN:-$(command -v python3 || true)}"

exec "$PYTHON_BIN" -u feishu_claude_code_bridge.py
