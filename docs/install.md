# 安装与卸载

## 前置条件

- macOS。
- Python 3。
- 已安装并登录 Claude Code CLI。
- 已准备飞书机器人的 `App ID` 和 `App Secret`。

## 一键安装

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/LpcPaul/FeishuClaudeCodeBridge/main/remote-install.sh)"
```

安装脚本会提示输入飞书应用凭证，然后自动安装 launchd 服务。

安装完成后不要直接结束配置。继续按 [安装后必做检查](post-install.md) 确认飞书后台已经把消息事件和卡片回调都切到长连接，否则卡片按钮会报 `code: 200340`。

## 手动安装

```bash
git clone https://github.com/LpcPaul/FeishuClaudeCodeBridge.git
cd FeishuClaudeCodeBridge
./install.sh
```

## 安装后必做

1. 在飞书开放平台「事件与回调」里选择长连接接收事件和回调。
2. 在「已订阅的事件」里添加 `im.message.receive_v1`。
3. 在「已订阅的回调」里添加 `card.action.trigger`。
4. 保存并发布新版应用。
5. 回到本机运行：

```bash
./bridge status
./bridge logs 30
```

完整验收清单见 [安装后必做检查](post-install.md)。

## 安装后位置

运行目录：

```text
~/Library/Application Support/FeishuClaudeCodeBridge
```

应用副本：

```text
~/Library/Application Support/FeishuClaudeCodeBridge/app
```

配置文件：

```text
~/Library/Application Support/FeishuClaudeCodeBridge/app/.env.feishu
```

LaunchAgent：

```text
~/Library/LaunchAgents/com.lpcpaul.feishu-claude-code-bridge.plist
```

## 服务管理

在项目目录里运行：

```bash
./bridge status
./bridge restart
./bridge logs
./bridge follow-logs
./bridge stop
./bridge start
```

## 卸载

只移除服务，保留状态库和配置：

```bash
./uninstall.sh
```

移除服务并删除运行数据：

```bash
REMOVE_FEISHU_CLAUDE_CODE_BRIDGE_DATA=1 ./uninstall.sh
```
