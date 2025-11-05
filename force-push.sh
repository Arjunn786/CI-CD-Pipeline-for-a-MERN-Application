#!/bin/bash

# Force Push to Main Branch Script

echo "⚠️  FORCE PUSH TO MAIN BRANCH"
echo "================================"
echo ""
echo "🚨 WARNING: This will overwrite the remote main branch!"
echo "This action cannot be undone and may affect other collaborators."
echo ""

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "❌ Error: Not in a Git repository. Please run 'git init' first."
    exit 1
fi

# Check if we have a remote origin
if ! git remote get-url origin >/dev/null 2>&1; then
    echo "❌ Error: No remote origin found."
    echo "Please add a remote first:"
    echo "git remote add origin <your-repo-url>"
    exit 1
fi

# Show current branch
CURRENT_BRANCH=$(git branch --show-current)
echo "📍 Current branch: $CURRENT_BRANCH"

# Switch to main branch if not already on it
if [ "$CURRENT_BRANCH" != "main" ]; then
    echo "🔄 Switching to main branch..."
    git checkout main 2>/dev/null || git checkout -b main
fi

# Show recent commits
echo ""
echo "📋 Recent commits on main branch:"
git log --oneline -5 2>/dev/null || echo "No commits found"
echo ""

# Confirmation prompt
read -p "🤔 Are you sure you want to force push to main? (type 'yes' to continue): " confirmation

if [ "$confirmation" != "yes" ]; then
    echo "❌ Force push cancelled."
    exit 0
fi

# Add all changes
echo "📦 Adding all changes..."
git add .

# Check if there are changes to commit
if ! git diff --staged --quiet; then
    echo "💾 Committing changes..."
    git commit -m "feat: Force push update - $(date '+%Y-%m-%d %H:%M:%S')

- Updated project configuration
- Ready for deployment
- Force pushing to synchronize remote"
else
    echo "ℹ️  No new changes to commit"
fi

# Force push to main
echo ""
echo "🚀 Force pushing to main branch..."
echo "Running: git push --force-with-lease origin main"

if git push --force-with-lease origin main; then
    echo ""
    echo "✅ Successfully force pushed to main branch!"
    echo ""
    echo "🎯 Next steps:"
    echo "1. Check GitHub Actions workflow execution"
    echo "2. Verify Docker image builds successfully"
    echo "3. Monitor CI/CD pipeline status"
    echo ""
    echo "🔗 GitHub Actions will trigger automatically for:"
    echo "- Running tests"
    echo "- Building Docker image"
    echo "- Pushing to Docker Hub"
    echo ""
    echo "📊 Current repository status:"
    git log --oneline -3
else
    echo ""
    echo "❌ Force push failed!"
    echo ""
    echo "💡 Possible solutions:"
    echo "1. Check your GitHub authentication"
    echo "2. Verify repository permissions"
    echo "3. Try: git push --force origin main (less safe)"
    echo ""
    echo "🔧 Debug commands:"
    echo "git remote -v"
    echo "git status"
    echo "git log --oneline -5"
fi

echo ""
echo "🏁 Script completed."