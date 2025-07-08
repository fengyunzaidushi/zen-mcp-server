#!/bin/bash

# AIGC369 Zen MCP Server 快速安装脚本
# 基于成功案例优化

echo "🚀 开始安装 Zen MCP Server with AIGC369..."

# 方式1：完整配置（推荐）
echo "📦 正在执行安装命令..."
claude mcp add zen sh -- -c "CUSTOM_API_URL=https://api.aigc369.com/v1 CUSTOM_API_KEY=sk-nTnL3K8UoIT98eImMq4aaPDGE3y9qE36xd4mePthb2cG5I5v exec \$(which uvx) --from git+https://github.com/BeehiveInnovations/zen-mcp-server.git zen-mcp-server"

if [ $? -eq 0 ]; then
    echo "✅ 安装成功！"
    echo ""
    echo "🔍 验证安装："
    echo "claude mcp list"
    echo ""
    echo "🎯 测试命令："
    echo 'claude chat "使用zen分析这段代码" --mcp zen'
    echo ""
    echo "📚 可用模型别名："
    echo "- gpt4-aigc (GPT-4o)"
    echo "- claude-aigc (Claude 3.5 Sonnet)" 
    echo "- gemini-aigc (Gemini 2.0 Flash)"
    echo "- o1-aigc (OpenAI o1)"
else
    echo "❌ 安装失败，尝试备用方案..."
    echo ""
    echo "🔄 尝试简化配置："
    claude mcp add zen sh -- -c "CUSTOM_API_KEY=sk-nTnL3K8UoIT98eImMq4aaPDGE3y9qE36xd4mePthb2cG5I5v exec \$(which uvx) --from git+https://github.com/BeehiveInnovations/zen-mcp-server.git zen-mcp-server"
    
    if [ $? -eq 0 ]; then
        echo "✅ 备用方案安装成功！"
        echo "⚠️  记得设置环境变量: export CUSTOM_API_URL=https://api.aigc369.com/v1"
    else
        echo "❌ 安装仍然失败"
        echo "📋 请尝试手动安装或检查网络连接"
        echo "🔗 参考文档: docs_local/aigc369-installation-commands.md"
    fi
fi 