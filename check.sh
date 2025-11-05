#!/bin/bash

# Quick Diagnostic Script

echo "🩺 Quick Diagnostic Check"
echo "========================"

# Check current directory
echo "📁 Current directory: $(pwd)"
echo "📋 Files in directory:"
ls -la

echo ""
echo "🔍 System checks:"

# Check if we're in the right place
if [ -f "package.json" ]; then
    echo "✅ package.json found"
else
    echo "❌ package.json NOT found"
    echo "💡 Make sure you're in the project directory"
    exit 1
fi

# Check Node.js
if command -v node >/dev/null 2>&1; then
    echo "✅ Node.js: $(node --version)"
else
    echo "❌ Node.js not found"
fi

# Check npm
if command -v npm >/dev/null 2>&1; then
    echo "✅ npm: $(npm --version)"
else
    echo "❌ npm not found"
fi

# Check Docker
if command -v docker >/dev/null 2>&1; then
    echo "✅ Docker: $(docker --version)"
    if docker info >/dev/null 2>&1; then
        echo "✅ Docker daemon running"
    else
        echo "❌ Docker daemon not running"
    fi
else
    echo "❌ Docker not found"
fi

# Check Git
if command -v git >/dev/null 2>&1; then
    echo "✅ Git: $(git --version)"
else
    echo "❌ Git not found"
fi

echo ""
echo "🔧 To run troubleshooting: ./troubleshoot.sh"
echo "🚀 To build and push: ./build-and-push.sh"