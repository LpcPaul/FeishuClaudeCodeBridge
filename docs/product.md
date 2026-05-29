# 产品定位

FeishuClaudeCodeBridge 面向已经使用 Claude Code CLI 的用户。

目标场景：

> 用户在手机或飞书里发任务，不需要打开终端或 Claude Code 桌面端，就能把任务交给本机 Claude Code，并在飞书里收到移动端可读的结果。

## 核心价值

- 让飞书成为本机 Claude Code 的自然语言入口。
- 保持 Claude Code 原有能力边界，不重做工具系统。
- 用轻量上下文管控解决主 Bot 长期聊天里的话题混乱。
- 让输出适合移动端阅读。

## 设计边界

FeishuClaudeCodeBridge 只做桥接和上下文管控。

它不做：

- Claude Code 执行过程可视化。
- Token、context footer、状态面板。
- 结果卡片模板。
- 飞书文档、表格、多维表格、任务系统的内置命令。
- 独立 Agent 路由平台。

这些能力应该由 Claude Code 自己的工具、插件或未来单独的 MCP 服务处理。
