# AIGC369 API 集成指南

## 概述

AIGC369 是一个类似 OpenRouter 的 AI API 提供商，支持多个主流 AI 模型。本指南将帮你配置 zen-mcp-server 使用 AIGC369 作为自定义 API 提供商。

## 配置步骤

### 1. 环境变量配置

在 `.env` 文件中添加以下配置：

```env
# AIGC369 API配置
CUSTOM_API_URL=https://api.aigc369.com/v1
CUSTOM_API_KEY=sk-nTnL3K8UoIT98eImMq4aaPDGE3y9qE36xd4mePthb2cG5I5v

# 默认模型（可选）
CUSTOM_MODEL_NAME=gpt-4o
```

### 2. Claude MCP Add 命令（基于成功案例优化）

```bash
# 推荐方式：完整AIGC369配置
claude mcp add zen sh -- -c "CUSTOM_API_URL=https://api.aigc369.com/v1 CUSTOM_API_KEY=sk-nTnL3K8UoIT98eImMq4aaPDGE3y9qE36xd4mePthb2cG5I5v exec $(which uvx) --from git+https://github.com/BeehiveInnovations/zen-mcp-server.git zen-mcp-server"

# 备用方式：简化配置
claude mcp add zen sh -- -c "CUSTOM_API_KEY=sk-nTnL3K8UoIT98eImMq4aaPDGE3y9qE36xd4mePthb2cG5I5v exec $(which uvx) --from git+https://github.com/BeehiveInnovations/zen-mcp-server.git zen-mcp-server"

# 一键安装脚本
bash docs_local/quick-install-aigc369.sh
```

**关键修改说明：**
- 使用 `$(which uvx)` 替代直接的 `uvx`
- 移除了 `--native-tls` 参数避免网络问题
- 基于社区成功案例优化

### 3. 本地开发配置

如果你是本地开发，修改项目根目录的 `.env` 文件：

```env
# AIGC369配置
CUSTOM_API_URL=https://api.aigc369.com/v1
CUSTOM_API_KEY=sk-nTnL3K8UoIT98eImMq4aaPDGE3y9qE36xd4mePthb2cG5I5v

# 禁用其他提供商（可选）
# GEMINI_API_KEY=
# OPENAI_API_KEY=
# OPENROUTER_API_KEY=
```

## 支持的 AIGC369 模型

基于你提供的模型列表，以下是主要的可用模型：

### OpenAI 系列

- `gpt-4o` - GPT-4 Omni 最新版本
- `gpt-4o-mini` - GPT-4 轻量版
- `gpt-4-turbo` - GPT-4 Turbo
- `gpt-3.5-turbo` - GPT-3.5 Turbo

### Claude 系列

- `claude-3-5-sonnet-latest` - Claude 3.5 Sonnet 最新版
- `claude-3-5-haiku-latest` - Claude 3.5 Haiku
- `claude-3-opus-20240229` - Claude 3 Opus

### Gemini 系列

- `gemini-2.0-flash` - Gemini 2.0 Flash
- `gemini-1.5-pro` - Gemini 1.5 Pro
- `gemini-1.5-flash` - Gemini 1.5 Flash

### 推理模型

- `o1` - OpenAI o1
- `o1-mini` - OpenAI o1 Mini
- `o3-mini` - OpenAI o3 Mini (如果可用)

## 使用方法

### 通过 zen 工具调用

```bash
# 使用默认模型
zen chat "你好，请介绍一下自己"

# 指定特定模型
zen chat "分析这段代码" --model gpt-4o

# 使用Claude模型
zen chat "帮我写个Python函数" --model claude-3-5-sonnet-latest

# 代码审查
zen codereview --model gpt-4o

# 深度分析
zen thinkdeep "解释量子计算的基本原理" --model claude-3-opus-20240229
```

### 模型别名配置

为了方便使用，你可以在 `conf/custom_models.json` 中添加模型别名：

```json
{
  "models": [
    {
      "model_name": "gpt-4o",
      "aliases": ["gpt4", "openai", "gpt"],
      "context_window": 128000,
      "max_output_tokens": 4096,
      "supports_function_calling": true,
      "supports_images": true,
      "is_custom": true,
      "description": "GPT-4 Omni via AIGC369"
    },
    {
      "model_name": "claude-3-5-sonnet-latest",
      "aliases": ["claude", "sonnet", "claude-sonnet"],
      "context_window": 200000,
      "max_output_tokens": 8192,
      "supports_function_calling": false,
      "supports_images": true,
      "is_custom": true,
      "description": "Claude 3.5 Sonnet via AIGC369"
    }
  ]
}
```

## 测试连接

使用 HTTP 文件测试 API 连接：

```http
### 获取模型列表
GET https://api.aigc369.com/v1/models HTTP/1.1
Authorization: Bearer sk-nTnL3K8UoIT98eImMq4aaPDGE3y9qE36xd4mePthb2cG5I5v
Content-Type: application/json

### 测试聊天完成
POST https://api.aigc369.com/v1/chat/completions HTTP/1.1
Authorization: Bearer sk-nTnL3K8UoIT98eImMq4aaPDGE3y9qE36xd4mePthb2cG5I5v
Content-Type: application/json

{
  "model": "gpt-4o",
  "messages": [
    {
      "role": "user",
      "content": "Hello, can you introduce yourself?"
    }
  ],
  "max_tokens": 150,
  "temperature": 0.7
}
```

## 故障排除

### 常见问题

1. **API 密钥错误**

   ```bash
   # 检查环境变量
   echo $CUSTOM_API_KEY
   # 验证API密钥格式
   ```

2. **模型不可用**

   ```bash
   # 查看可用模型列表
   curl -H "Authorization: Bearer sk-nTnL3K8UoIT98eImMq4aaPDGE3y9qE36xd4mePthb2cG5I5v" \
        https://api.aigc369.com/v1/models
   ```

3. **连接超时**
   ```env
   # 增加超时设置
   CUSTOM_API_TIMEOUT=60
   ```

### 调试模式

启用详细日志：

```bash
# 设置日志级别
export LOG_LEVEL=DEBUG

# 运行zen-mcp-server
python server.py
```

## 优势对比

### AIGC369 vs 直接 API 调用

- ✅ 统一接口访问多个模型
- ✅ 成本优化和额度管理
- ✅ 高可用性和负载均衡
- ✅ 简化的计费和使用统计

### AIGC369 vs OpenRouter

- ✅ 可能更好的国内访问速度
- ✅ 本地化支持和服务
- ⚠️ 需要验证模型更新频率
- ⚠️ 需要确认服务稳定性

## 高级配置

### 多提供商混合使用

你可以同时配置多个提供商：

```env
# 主要使用AIGC369
CUSTOM_API_URL=https://api.aigc369.com/v1
CUSTOM_API_KEY=your_aigc369_key

# 备用OpenRouter
OPENROUTER_API_KEY=your_openrouter_key

# 特定任务使用Gemini
GEMINI_API_KEY=your_gemini_key
```

### 智能模型路由

利用 zen-mcp-server 的 auto 模式：

```env
DEFAULT_MODEL=auto
```

这样 Claude 会自动为不同任务选择最合适的模型。

## 注意事项

1. **API 限制**: 确认 AIGC369 的请求频率和并发限制
2. **模型可用性**: 某些模型可能有地区或时间限制
3. **成本控制**: 监控 API 使用量，避免意外费用
4. **数据安全**: 确保敏感数据处理符合隐私要求

## 更新和维护

定期检查：

- AIGC369 的新模型发布
- API 接口更新
- zen-mcp-server 的配置优化

通过这个配置，你就可以通过 zen-mcp-server 使用 AIGC369 的所有 AI 模型了！
