# AIGC369 Zen MCP Server 安装命令

## 推荐的安装命令（基于成功案例修改）

### 方式 1：基础 AIGC369 配置（推荐）

```bash
claude mcp add zen sh -- -c "CUSTOM_API_URL=https://api.aigc369.com/v1 CUSTOM_API_KEY=sk-nTnL3K8UoIT98eImMq4aaPDGE3y9qE36xd4mePthb2cG5I5v exec $(which uvx) --from git+https://github.com/BeehiveInnovations/zen-mcp-server.git zen-mcp-server"
```

### 方式 2：仅设置 API 密钥，URL 通过环境变量

```bash
claude mcp add zen sh -- -c "CUSTOM_API_KEY=sk-nTnL3K8UoIT98eImMq4aaPDGE3y9qE36xd4mePthb2cG5I5v exec $(which uvx) --from git+https://github.com/BeehiveInnovations/zen-mcp-server.git zen-mcp-server"
```

_注意：这种方式需要你在系统环境变量中设置 `CUSTOM_API_URL=https://api.aigc369.com/v1`_

### 方式 3：多个 API 密钥同时设置

```bash
claude mcp add zen sh -- -c "CUSTOM_API_URL=https://api.aigc369.com/v1 CUSTOM_API_KEY=sk-nTnL3K8UoIT98eImMq4aaPDGE3y9qE36xd4mePthb2cG5I5v GEMINI_API_KEY= OPENAI_API_KEY= exec $(which uvx) --from git+https://github.com/BeehiveInnovations/zen-mcp-server.git zen-mcp-server"
```

### 方式 4：使用默认模型设置

```bash
claude mcp add zen sh -- -c "CUSTOM_API_URL=https://api.aigc369.com/v1 CUSTOM_API_KEY=sk-nTnL3K8UoIT98eImMq4aaPDGE3y9qE36xd4mePthb2cG5I5v DEFAULT_MODEL=gpt-4o exec $(which uvx) --from git+https://github.com/BeehiveInnovations/zen-mcp-server.git zen-mcp-server"
```

## 关键修改说明

与失败的命令相比，这些命令的关键修改：

1. **使用 `$(which uvx)`** - 动态获取 uvx 路径，避免路径问题
2. **移除 `--native-tls`** - 避免 TLS 相关的网络问题
3. **使用 `exec`** - 进程替换，优化内存使用
4. **简化环境变量** - 减少可能的配置冲突

## 如果仍然失败的备用方案

### 本地安装方式

如果 GitHub 访问还是有问题，可以先本地克隆：

```bash
# 1. 克隆仓库到本地
git clone https://github.com/BeehiveInnovations/zen-mcp-server.git
cd zen-mcp-server

# 2. 配置环境变量
echo "CUSTOM_API_URL=https://api.aigc369.com/v1" > .env
echo "CUSTOM_API_KEY=sk-nTnL3K8UoIT98eImMq4aaPDGE3y9qE36xd4mePthb2cG5I5v" >> .env

# 3. 安装依赖
pip install -e .

# 4. 使用本地路径添加到Claude
claude mcp add zen -e CUSTOM_API_URL=https://api.aigc369.com/v1 -e CUSTOM_API_KEY=sk-nTnL3K8UoIT98eImMq4aaPDGE3y9qE36xd4mePthb2cG5I5v -- python /path/to/zen-mcp-server/server.py
```

### 使用镜像仓库（如果 GitHub 访问困难）

```bash
# 如果有gitee镜像
claude mcp add zen sh -- -c "CUSTOM_API_URL=https://api.aigc369.com/v1 CUSTOM_API_KEY=sk-nTnL3K8UoIT98eImMq4aaPDGE3y9qE36xd4mePthb2cG5I5v exec $(which uvx) --from git+https://gitee.com/your-mirror/zen-mcp-server.git zen-mcp-server"
```

## 验证安装成功

安装成功后，可以通过以下方式验证：

```bash
# 检查MCP服务器列表
claude mcp list

# 测试zen工具
claude mcp run zen -- --help
```

## 故障排除

如果安装失败，检查以下项目：

1. **网络连接**：确保可以访问 GitHub
2. **uvx 版本**：`uvx --version`
3. **Claude CLI 版本**：`claude --version`
4. **Python 环境**：确保 Python 3.10+可用

选择最适合你网络环境的安装方式试试！
