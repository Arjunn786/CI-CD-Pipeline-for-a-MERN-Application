#!/bin/bash

# Build and Push to Main Script
# This script builds the project locally, runs tests, and pushes to main

# Exit on any error
set -e

echo "🚀 MERN CI/CD Pipeline - Build and Push to Main"
echo "==============================================="
echo ""

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    print_error "package.json not found. Please run this script from the project root."
    exit 1
fi

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    print_error "Not in a Git repository. Please run 'git init' first."
    exit 1
fi

print_status "Starting build process..."

# Step 0: Clean up ports
print_status "🧹 Cleaning up ports..."
chmod +x cleanup-ports.sh
./cleanup-ports.sh

# Step 1: Clean and install dependencies
print_status "📦 Installing dependencies..."
if [ -f "package-lock.json" ]; then
    npm ci
else
    npm install
fi

print_success "Dependencies installed successfully"

# Step 2: Run tests
print_status "🧪 Running tests..."
if npm test; then
    print_success "All tests passed!"
else
    print_error "Tests failed! Cannot proceed with push to main."
    echo ""
    print_warning "Please fix the failing tests before pushing to main."
    exit 1
fi

# Step 3: Build Docker image locally (optional verification)
print_status "🐳 Building Docker image locally for verification..."
if docker build -t mern-cicd-app:local-test .; then
    print_success "Docker image built successfully"
else
    print_error "Docker build failed!"
    exit 1
fi

# Step 4: Test Docker container locally
print_status "🔍 Testing Docker container locally..."
docker run -d -p 3001:3000 --name local-test-container mern-cicd-app:local-test

# Wait for container to start
sleep 5

# Test the health endpoint
if curl -f http://localhost:3001/api/health >/dev/null 2>&1; then
    print_success "Local Docker container test passed"
    docker stop local-test-container >/dev/null 2>&1
    docker rm local-test-container >/dev/null 2>&1
else
    print_error "Local Docker container test failed"
    docker stop local-test-container >/dev/null 2>&1
    docker rm local-test-container >/dev/null 2>&1
    exit 1
fi

# Clean up local test image
docker rmi mern-cicd-app:local-test >/dev/null 2>&1

# Step 5: Git operations
print_status "📝 Preparing Git commit..."

# Add all changes
git add .

# Check if there are changes to commit
if git diff --staged --quiet; then
    print_warning "No changes to commit"
else
    # Create commit with timestamp
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    git commit -m "build: Production build and deployment - $TIMESTAMP

✅ All tests passed
🐳 Docker build verified locally
🚀 Ready for CI/CD deployment

Changes:
- Updated application code
- Verified local build process
- Ready for production deployment"

    print_success "Changes committed successfully"
fi

# Step 6: Push to main
print_status "🚀 Pushing to main branch..."

# Get current branch
CURRENT_BRANCH=$(git branch --show-current)

# Switch to main if not already there
if [ "$CURRENT_BRANCH" != "main" ]; then
    print_status "Switching to main branch..."
    git checkout main 2>/dev/null || git checkout -b main
    
    # Merge current branch if it's not main
    if [ "$CURRENT_BRANCH" != "main" ]; then
        print_status "Merging $CURRENT_BRANCH into main..."
        git merge "$CURRENT_BRANCH" --no-ff -m "Merge $CURRENT_BRANCH into main for deployment"
    fi
fi

# Push to main
if git push origin main; then
    print_success "Successfully pushed to main branch!"
else
    print_error "Failed to push to main branch"
    echo ""
    print_warning "You might need to:"
    echo "1. Set up remote origin: git remote add origin <repo-url>"
    echo "2. Authenticate with GitHub"
    echo "3. Check repository permissions"
    exit 1
fi

# Step 7: Monitor CI/CD
echo ""
print_success "🎉 Build and push completed successfully!"
echo ""
echo "📊 What happens next:"
echo "1. ✅ GitHub Actions will trigger automatically"
echo "2. 🧪 CI/CD pipeline will run tests again"
echo "3. 🐳 Docker image will be built and pushed to Docker Hub"
echo "4. 🔍 Deployment verification will run"
echo ""
echo "🔗 Monitor your pipeline at:"
echo "   https://github.com/<username>/<repo>/actions"
echo ""
echo "🐳 Docker Hub repository:"
echo "   https://hub.docker.com/r/<username>/mern-cicd-app"
echo ""
echo "⏱️  Expected pipeline duration: 3-5 minutes"
echo ""

# Show recent commits
print_status "📋 Recent commits:"
git log --oneline -3

echo ""
print_success "🚀 Deployment pipeline initiated!"
echo "Check GitHub Actions for real-time progress."