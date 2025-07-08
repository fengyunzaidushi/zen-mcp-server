# Zen MCP Server 使用指南

## 概述

Zen MCP Server 是一个强大的多提供商 AI 工具服务器，基于 Model Context Protocol (MCP)协议开发。它允许 Claude 通过统一接口访问多个 AI 模型提供商，并提供丰富的开发工具来增强工作流程。

## 主要特性

- **多 AI 提供商支持**: 支持 Google Gemini、OpenAI、X.AI(GROK)、OpenRouter 和自定义 API 端点
- **智能模型编排**: 自动选择最适合任务的 AI 模型
- **丰富的开发工具**: 包含分析、调试、规划、代码审查等 15+专业工具
- **会话记忆系统**: 支持跨工具的多轮对话
- **视觉支持**: 支持图像分析的 AI 模型
- **Docker 部署**: 完整的容器化部署方案

## 快速开始

### 系统要求

- Python 3.10+ (推荐 3.12)
- Git
- Windows 用户需要 WSL2
- 至少一个 AI 提供商的 API 密钥

### 安装步骤

1. **克隆仓库**

```bash
git clone https://github.com/BeehiveInnovations/zen-mcp-server.git
cd zen-mcp-server
```

2. **运行安装脚本**

```bash
./run-server.sh
```

该脚本会自动完成以下任务：

- 创建 Python 虚拟环境
- 安装依赖包
- 设置环境配置
- 配置 Claude 集成
- 验证 API 密钥

3. **配置 API 密钥**

```bash
nano .env
```

至少需要配置以下一项：

```env
# Google Gemini
GEMINI_API_KEY=your_gemini_key

# OpenAI
OPENAI_API_KEY=your_openai_key

# OpenRouter (统一API)
OPENROUTER_API_KEY=your_openrouter_key

# X.AI (GROK)
XAI_API_KEY=your_xai_key

# 自定义API端点
CUSTOM_API_URL=http://localhost:11434/v1
CUSTOM_API_KEY=optional_key
CUSTOM_MODEL_NAME=llama3
```

## AI 提供商配置

### 支持的提供商

1. **Google Gemini**

   - 模型: Gemini 2.5 Pro, Gemini 2.5 Flash
   - 配置: `GEMINI_API_KEY`

2. **OpenAI**

   - 模型: O3, O3-mini, O4-mini, O4-mini-high
   - 配置: `OPENAI_API_KEY`

3. **X.AI (GROK)**

   - 模型: grok-3, grok-3-fast
   - 配置: `XAI_API_KEY`

4. **OpenRouter**

   - 提供访问 Claude、Mistral、Llama 等多种模型
   - 配置: `OPENROUTER_API_KEY`

5. **自定义 API 端点**
   - 支持本地模型 (Ollama, vLLM, LM Studio)
   - 兼容 OpenAI API 格式

### 模型选择模式

- **自动模式**: `DEFAULT_MODEL=auto` - Claude 自动选择最适合的模型
- **固定模式**: 指定具体模型名，如 `DEFAULT_MODEL=pro`

### 模型使用限制

通过环境变量限制可用模型：

```env
OPENAI_ALLOWED_MODELS=o3,o3-mini
GOOGLE_ALLOWED_MODELS=gemini-2.5-pro,gemini-2.5-flash
XAI_ALLOWED_MODELS=grok-3
```

## 核心工具介绍

### 工作流工具

1. **chat** - 协作思考伙伴

   - 用途: 头脑风暴、获取第二意见、验证方案
   - 使用: "与 zen 聊天讨论用户认证的最佳方案"

2. **thinkdeep** - 深度分析工具

   - 用途: 挑战假设、识别边界情况、深度分析
   - 使用: "使用 thinkdeep 深入分析这个架构设计"

3. **planner** - 项目规划工具

   - 用途: 将复杂项目分解为可管理的结构化计划
   - 使用: "使用 planner 规划如何添加自然语言支持"

4. **consensus** - 多模型共识工具

   - 用途: 收集多个 AI 模型对技术提案的意见
   - 使用: "获取共识评估是否应该从 REST 迁移到 GraphQL"

5. **codereview** - 代码审查工具

   - 用途: 专业代码审查，识别 bug、安全漏洞和性能问题
   - 使用: "使用 zen 对这段代码进行安全审查"

6. **debug** - 系统调试工具

   - 用途: 系统化调试指导，逐步根因分析
   - 使用: "使用 zen 调试为什么这个测试失败"

7. **analyze** - 代码分析工具

   - 用途: 通用代码理解和探索
   - 使用: "使用 zen 分析这些文件了解数据流"

8. **refactor** - 重构分析工具

   - 用途: 全面的重构分析，自顶向下分解策略
   - 使用: "使用 gemini pro 将这个大类分解为更小的扩展"

9. **tracer** - 调用流追踪工具

   - 用途: 详细分析调用流映射和依赖追踪
   - 使用: "使用 zen tracer 分析 UserAuthManager.authenticate 的使用"

10. **testgen** - 测试生成工具

    - 用途: 生成全面的测试套件，覆盖边界情况
    - 使用: "使用 zen 为 User.login()方法生成测试"

11. **secaudit** - 安全审计工具

    - 用途: 基于 OWASP 的系统化安全评估
    - 使用: "对电商应用进行 secaudit，关注支付处理安全"

12. **docgen** - 文档生成工具

    - 用途: 生成全面文档，包含复杂度分析
    - 使用: "使用 docgen 为 UserManager 类生成文档"

13. **precommit** - 提交前验证工具
    - 用途: 验证 git 更改，确保合规性
    - 使用: "执行 precommit 检查确保没有回归"

### 实用工具

- **listmodels** - 列出所有可用 AI 模型
- **version** - 显示服务器版本和配置信息

## 使用方法

### 基本使用

在 Claude 中自然地表达需求，通常包含"zen"关键词：

```
"与zen聊天讨论这个架构设计"
"使用zen深入分析这个bug"
"让zen帮我规划这个功能实现"
```

### 结构化提示

使用 `/zen:[工具名] [消息]` 格式直接调用工具：

```
/zen:thinkdeep 分析这个性能瓶颈的根本原因
/zen:codereview 检查这段代码的安全问题
/zen:planner 规划用户认证系统的实现
```

### 指定模型

可以明确指定使用哪个 AI 模型：

```
"使用gemini pro分析这个架构"
"用o3模型进行深度思考"
"让flash快速审查这段代码"
```

## 高级配置

### 环境变量配置

```env
# 默认模型
DEFAULT_MODEL=auto

# 思考模式
DEFAULT_THINKING_MODE_THINKDEEP=high

# 会话管理
CONVERSATION_TIMEOUT_HOURS=24
MAX_CONVERSATION_TURNS=50

# 日志级别
LOG_LEVEL=INFO

# 禁用工具
DISABLED_TOOLS=tool1,tool2

# 令牌限制
MAX_MCP_OUTPUT_TOKENS=100000
```

### 自定义模型配置

编辑 `conf/custom_models.json` 文件定义自定义模型：

```json
{
  "custom_models": {
    "llama3": {
      "name": "llama3",
      "aliases": ["llama", "llama3"],
      "context_window": 8192,
      "supports_json_mode": true,
      "supports_function_calling": false,
      "supports_vision": false
    }
  }
}
```

## Docker 部署

### 使用 Docker Compose

1. **配置环境变量**

```bash
# 复制并编辑环境文件
cp .env.example .env
nano .env
```

2. **启动服务**

```bash
docker-compose up -d
```

### Docker 服务架构

- **zen-mcp**: 主服务器
- **redis**: 会话数据存储
- **log-monitor**: 日志监控

### Docker 配置选项

```yaml
environment:
  - DEFAULT_MODEL=${DEFAULT_MODEL:-auto}
  - GEMINI_API_KEY=${GEMINI_API_KEY}
  - LOG_LEVEL=${LOG_LEVEL:-INFO}
  - DEFAULT_THINKING_MODE_THINKDEEP=${DEFAULT_THINKING_MODE_THINKDEEP:-high}

volumes:
  - ./logs:/app/logs
  - zen-mcp-config:/app/conf

deploy:
  resources:
    limits:
      memory: 512M
      cpus: "0.5"
```

## 集成设置

### Claude Desktop 集成

运行安装脚本后，会自动配置 Claude Desktop：

```bash
./run-server.sh -c  # 获取配置说明
```

手动配置 `claude_desktop_config.json`：

```json
{
  "mcpServers": {
    "zen": {
      "command": "python",
      "args": ["/path/to/zen-mcp-server/server.py"],
      "env": {
        "GEMINI_API_KEY": "your_key"
      }
    }
  }
}
```

### Claude CLI 集成

```bash
claude mcp add zen
```

## 故障排除

### 常见问题

1. **API 密钥无效**

   - 检查 `.env` 文件中的 API 密钥
   - 确保密钥有足够的权限

2. **模型不可用**

   - 使用 `listmodels` 工具查看可用模型
   - 检查模型限制配置

3. **内存不足**

   - 调整 Docker 资源限制
   - 减少并发请求数量

4. **连接问题**
   - 检查网络连接
   - 验证 API 端点可访问性

### 调试方法

1. **查看日志**

```bash
tail -f logs/zen-mcp-server.log
```

2. **检查服务状态**

```bash
./run-server.sh --status
```

3. **验证配置**

```bash
python server.py --check-config
```

## 最佳实践

### 性能优化

1. **合理选择模型**: 快速任务用 Flash，复杂分析用 Pro
2. **批量处理**: 将相关任务组合在一起处理
3. **缓存利用**: 利用会话记忆避免重复分析

### 成本控制

1. **设置模型限制**: 使用 `*_ALLOWED_MODELS` 环境变量
2. **监控使用情况**: 定期检查 API 使用量
3. **优化提示**: 使用精确、简洁的提示

### 安全考虑

1. **API 密钥保护**: 不要在代码中硬编码密钥
2. **网络安全**: 使用 HTTPS 和 VPN 保护 API 通信
3. **访问控制**: 限制工具访问权限

## 更新维护

### 更新服务器

```bash
git pull origin main
./run-server.sh
```

### 清理 Docker 环境

```bash
./run-server.sh --cleanup-docker
```

### 备份配置

```bash
cp .env .env.backup
cp -r conf/ conf.backup/
```

## 总结

Zen MCP Server 提供了一个强大而灵活的 AI 工具编排平台，通过统一接口访问多个 AI 模型，大大提升了开发效率和代码质量。合理配置和使用这些工具，可以显著改善你的开发工作流程。

更多详细信息请参考项目文档和源代码。
