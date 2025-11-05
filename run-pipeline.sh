#!/bin/bash

# Quick Pipeline Runner Script

echo "🚀 Running CI/CD Pipeline"
echo "========================="

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo "❌ package.json not found. Please run from project root."
    exit 1
fi

print_status "Starting pipeline run..."

# Make scripts executable
chmod +x *.sh

# Clean up any running processes
print_status "🧹 Cleaning up ports..."
./cleanup-ports.sh

# Run the full build and push pipeline
print_status "🚀 Running build and push to main..."
./build-and-push.sh

if [ $? -eq 0 ]; then
    print_success "🎉 Pipeline completed successfully!"
    echo ""
    echo "📊 What's happening now:"
    echo "1. ✅ Code pushed to GitHub"
    echo "2. 🔄 GitHub Actions is running automatically"
    echo "3. 🧪 Tests are being executed in the cloud"
    echo "4. 🐳 Docker image is being built"
    echo ""
    echo "🔗 Monitor the progress:"
    echo "GitHub Actions: https://github.com/<username>/<repo>/actions"
    echo ""
    echo "⏱️ Expected completion: 3-5 minutes"
else
    echo "❌ Pipeline failed. Check the errors above."
    exit 1
fi