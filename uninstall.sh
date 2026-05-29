#!/usr/bin/env bash
set -euo pipefail

LABEL="com.lpcpaul.feishu-claude-code-bridge"
RUNTIME_DIR="${FEISHU_CLAUDE_CODE_RUNTIME_DIR:-${HOME}/Library/Application Support/FeishuClaudeCodeBridge}"
PLIST_PATH="${HOME}/Library/LaunchAgents/${LABEL}.plist"

launchctl bootout "gui/$(id -u)/${LABEL}" >/dev/null 2>&1 || true
launchctl bootout "gui/$(id -u)" "$PLIST_PATH" >/dev/null 2>&1 || true
rm -f "$PLIST_PATH"

if [[ "${REMOVE_FEISHU_CLAUDE_CODE_BRIDGE_DATA:-0}" == "1" ]]; then
  rm -rf "$RUNTIME_DIR"
  echo "FeishuClaudeCodeBridge service and runtime data removed."
else
  echo "FeishuClaudeCodeBridge service removed. Runtime data kept at: $RUNTIME_DIR"
  echo "Set REMOVE_FEISHU_CLAUDE_CODE_BRIDGE_DATA=1 to delete runtime data during uninstall."
fi
