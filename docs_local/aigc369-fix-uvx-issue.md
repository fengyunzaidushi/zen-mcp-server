# 解决 uvx not found 问题 - AIGC369 安装指南

## 问题分析

如果遇到 "uvx not found" 错误，这意味着你的系统中没有安装 uvx 工具，或者 uvx 已被替换为新的 uv 工具。

## 解决方案

### 方案 1：使用 uv tool run 替代 uvx（推荐）

新版本的 uv 工具已经将 uvx 功能合并到 `uv tool run` 中：

```bash
# AIGC369配置 - 使用uv tool run
claude mcp add zen sh -- -c "CUSTOM_API_URL=https://api.aigc369.com/v1 CUSTOM_API_KEY=sk-nTnL3K8UoIT98eImMq4aaPDGE3y9qE36xd4mePthb2cG5I5v exec uv tool run --from git+https://github.com/BeehiveInnovations/zen-mcp-server.git zen-mcp-server"

# 备用简化版本
claude mcp add zen sh -- -c "CUSTOM_API_KEY=sk-nTnL3K8UoIT98eImMq4aaPDGE3y9qE36xd4mePthb2cG5I5v exec uv tool run --from git+https://github.com/BeehiveInnovations/zen-mcp-server.git zen-mcp-server"
```

### 方案 2：手动安装 uvx

```bash
# 安装最新版本的uv (包含uvx)
pip install -U uv

# 检查uvx是否可用
uvx --version

# 如果uvx可用，使用原命令
claude mcp add zen sh -- -c "CUSTOM_API_URL=https://api.aigc369.com/v1 CUSTOM_API_KEY=sk-nTnL3K8UoIT98eImMq4aaPDGE3y9qE36xd4mePthb2cG5I5v exec $(which uvx) --from git+https://github.com/BeehiveInnovations/zen-mcp-server.git zen-mcp-server"
```

### 方案 3：本地 git 安装（最稳定）

```bash
# 1. 克隆仓库
git clone https://github.com/BeehiveInnovations/zen-mcp-server.git
cd zen-mcp-server

# 2. 创建虚拟环境和安装
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -e .

# 3. 配置环境变量
echo "CUSTOM_API_URL=https://api.aigc369.com/v1" > .env
echo "CUSTOM_API_KEY=sk-nTnL3K8UoIT98eImMq4aaPDGE3y9qE36xd4mePthb2cG5I5v" >> .env

# 4. 添加到Claude MCP
claude mcp add zen -e CUSTOM_API_URL=https://api.aigc369.com/v1 -e CUSTOM_API_KEY=sk-nTnL3K8UoIT98eImMq4aaPDGE3y9qE36xd4mePthb2cG5I5v -- python /path/to/zen-mcp-server/server.py
```

### 方案 4：使用 pipx 替代 uvx

```bash
# 安装pipx
pip install pipx

# 使用pipx安装
claude mcp add zen sh -- -c "CUSTOM_API_URL=https://api.aigc369.com/v1 CUSTOM_API_KEY=sk-nTnL3K8UoIT98eImMq4aaPDGE3y9qE36xd4mePthb2cG5I5v exec pipx run --spec git+https://github.com/BeehiveInnovations/zen-mcp-server.git zen-mcp-server"
```

## 注意事项

1. **API 密钥配置**：确保使用 `CUSTOM_API_KEY` 而不是 `GEMINI_API_KEY`
2. **AIGC369 配置**：必须设置 `CUSTOM_API_URL=https://api.aigc369.com/v1`
3. **路径问题**：如果使用本地安装，记得替换为实际的项目路径

## 验证安装

安装成功后运行：

```bash
# 检查MCP服务器
claude mcp list

# 测试zen功能
claude chat "你好！使用AIGC369 API测试" --mcp zen
```

## 故障排除

如果仍然有问题：

1. **检查 Python 环境**：`python --version` (需要 3.10+)
2. **检查 uv 版本**：`uv --version`
3. **检查网络连接**：确保可以访问 GitHub
4. **检查 Claude CLI**：`claude --version`

选择最适合你环境的方案进行安装！
