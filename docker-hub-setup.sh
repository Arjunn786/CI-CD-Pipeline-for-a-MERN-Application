#!/bin/bash

# Docker Hub Setup Guide Script

echo "🐳 Docker Hub Integration Setup Guide"
echo "====================================="
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_step() {
    echo -e "${BLUE}[STEP]${NC} $1"
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

print_step "Docker Hub Account Setup"
echo "1. Create a Docker Hub account at https://hub.docker.com/"
echo "2. Verify your email address"
echo ""

print_step "Create Docker Hub Access Token"
echo "1. Go to Docker Hub → Account Settings → Security"
echo "2. Click 'New Access Token'"
echo "3. Give it a name like 'GitHub-Actions-CI-CD'"
echo "4. Set permissions to 'Read, Write, Delete'"
echo "5. Click 'Generate' and COPY the token (you won't see it again!)"
echo ""

print_step "GitHub Repository Secrets Setup"
echo "1. Go to your GitHub repository"
echo "2. Click Settings → Secrets and Variables → Actions"
echo "3. Click 'New repository secret'"
echo "4. Add these two secrets:"
echo ""
echo "   Secret Name: DOCKER_HUB_USERNAME"
echo "   Secret Value: [Your Docker Hub username]"
echo ""
echo "   Secret Name: DOCKER_HUB_ACCESS_TOKEN"
echo "   Secret Value: [The access token you copied]"
echo ""

print_step "Test Docker Hub Login Locally"
echo "To test your Docker Hub credentials locally:"
echo ""
echo "docker login"
echo "Username: [your-username]"
echo "Password: [your-access-token]"
echo ""

print_step "Create Docker Hub Repository"
echo "1. Go to Docker Hub → Repositories"
echo "2. Click 'Create Repository'"
echo "3. Repository name: mern-cicd-app"
echo "4. Make it public or private (your choice)"
echo "5. Click 'Create'"
echo ""

print_warning "Common Issues and Solutions:"
echo ""
echo "❌ Error: Username and password required"
echo "   → GitHub Secrets not set up correctly"
echo "   → Check secret names are exactly: DOCKER_HUB_USERNAME and DOCKER_HUB_ACCESS_TOKEN"
echo ""
echo "❌ Error: Authentication failed"
echo "   → Wrong username or token"
echo "   → Regenerate access token and update GitHub secret"
echo ""
echo "❌ Error: Repository does not exist"
echo "   → Create the repository on Docker Hub first"
echo "   → Check repository name matches workflow file"
echo ""

print_step "Verify Setup"
echo "After setting up secrets, check:"
echo "1. GitHub → Settings → Secrets → Actions"
echo "2. You should see both secrets listed"
echo "3. Re-run the GitHub Actions workflow"
echo ""

echo "🔗 Useful Links:"
echo "Docker Hub: https://hub.docker.com/"
echo "GitHub Secrets: https://github.com/[username]/[repo]/settings/secrets/actions"
echo ""

print_success "Setup guide completed!"
echo "Once you've completed these steps, your CI/CD pipeline should work correctly."