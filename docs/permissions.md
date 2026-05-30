# 权限说明

FeishuClaudeCodeBridge 的基础目标是把飞书消息转给本机 Claude Code，并把 Claude Code 文本回复发回飞书。

建议第一次配置飞书应用时，除了消息收发，也把交互卡片、飞书文档和创建群组权限一起申请好。完整 JSON 见 [初始权限清单](initial-permissions.md)。

## 最小权限

| 权限 | 是否必需 | 说明 |
| --- | --- | --- |
| `im:message.p2p_msg:readonly` | 私聊必需 | 机器人接收单聊消息 |
| `im:message.group_at_msg:readonly` | 群聊 @ 必需 | 机器人接收群聊中 @ 它的消息 |
| `im:message:send_as_bot` | 必需 | 机器人回复消息 |

## 事件订阅

需要订阅：

```text
im.message.receive_v1
card.action.trigger
```

Bridge 使用飞书长连接能力接收这些事件。没有卡片回调事件时，普通消息仍可使用，但卡片按钮不会续回会话。

## 建议初始权限

| 权限或事件 | 是否必需 | 说明 |
| --- | --- | --- |
| `card.action.trigger` | 卡片按钮必需 | 用户点击卡片按钮后，Bridge 才能收到回调 |
| `cardkit:card:write` | CardKit 可选 | 后续启用 CardKit 2.0 卡片创建/更新时使用 |
| `docx:document` | 文档可选 | 后续创建和编辑飞书新版文档时使用 |
| `docx:document:create` | 文档可选 | 只需要创建新版文档时使用 |
| `im:chat:create` | 建群可选 | 后续支持一条命令创建飞书群 |
| `im:chat` | 建群可选 | 配合建群后的群信息获取和更新 |

## 不默认申请的权限

| 权限 | 原因 |
| --- | --- |
| `im:message.group_msg` | 可读取群内所有消息，敏感度更高；只有需要“不 @ 也能读取群消息”时才考虑 |
| 飞书表格权限 | Bridge 不内置表格读取能力 |
| 多维表格权限 | Bridge 不内置多维表格能力 |
| 任务权限 | Bridge 不内置任务系统能力 |

## 权限生效提醒

飞书应用权限变化后，通常需要重新发布应用版本，或等待管理员审批。权限未生效时，Bridge 可能能启动，但收不到消息或无法回复。
