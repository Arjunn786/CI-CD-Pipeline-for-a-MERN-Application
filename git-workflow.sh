#!/bin/bash

# Git Workflow Script - Create branch and merge to main

echo "🚀 Starting Git workflow..."

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "📁 Initializing Git repository..."
    git init
    git config user.name "Your Name"
    git config user.email "your.email@example.com"
fi

# Add all files to staging
echo "📦 Adding files to staging..."
git add .

# Check if there are any changes to commit
if git diff --staged --quiet; then
    echo "ℹ️  No changes to commit"
else
    # Initial commit if this is the first commit
    if ! git rev-parse --verify HEAD >/dev/null 2>&1; then
        echo "🎯 Creating initial commit..."
        git commit -m "Initial commit: MERN CI/CD pipeline setup

- Express.js backend with REST API endpoints
- Docker containerization with multi-stage build
- GitHub Actions CI/CD pipeline
- Jest testing suite
- Comprehensive documentation"
    fi
fi

# Create and switch to feature branch
BRANCH_NAME="feature/cicd-pipeline-setup"
echo "🌿 Creating and switching to branch: $BRANCH_NAME"
git checkout -b "$BRANCH_NAME" 2>/dev/null || git checkout "$BRANCH_NAME"

# Make a small change to trigger a commit
echo "📝 Adding branch information to README..."
echo "" >> README.md
echo "## 🌿 Current Branch" >> README.md
echo "This commit was made on branch: \`$BRANCH_NAME\`" >> README.md
echo "Timestamp: $(date)" >> README.md

# Commit the changes
git add README.md
git commit -m "docs: Add branch information to README

- Added current branch and timestamp information
- Preparing for merge to main branch"

# Switch to main branch (create if doesn't exist)
echo "🔄 Switching to main branch..."
git checkout main 2>/dev/null || git checkout -b main

# Merge the feature branch
echo "🔀 Merging $BRANCH_NAME into main..."
git merge "$BRANCH_NAME" --no-ff -m "Merge branch '$BRANCH_NAME' into main

Features added:
- Complete MERN application setup
- Docker containerization
- CI/CD pipeline with GitHub Actions
- Automated testing
- Production-ready configuration"

# Clean up the feature branch
echo "🧹 Cleaning up feature branch..."
git branch -d "$BRANCH_NAME"

# Show the current status
echo "✅ Git workflow completed successfully!"
echo ""
echo "📊 Current repository status:"
git log --oneline -5
echo ""
echo "🎯 Next steps:"
echo "1. Create a GitHub repository"
echo "2. Add remote origin: git remote add origin <your-repo-url>"
echo "3. Push to GitHub: git push -u origin main"
echo "4. Set up Docker Hub secrets in GitHub repository settings"
echo ""
echo "🔗 Required GitHub Secrets:"
echo "- DOCKER_HUB_USERNAME"
echo "- DOCKER_HUB_ACCESS_TOKEN"