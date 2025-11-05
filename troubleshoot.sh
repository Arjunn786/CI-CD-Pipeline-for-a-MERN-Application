#!/bin/bash

# Troubleshooting Script for MERN CI/CD Pipeline

echo "🔧 MERN CI/CD Pipeline Troubleshooting"
echo "======================================"
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_check() {
    echo -e "${BLUE}[CHECK]${NC} $1"
}

print_ok() {
    echo -e "${GREEN}[OK]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check 1: Node.js and npm
print_check "Checking Node.js and npm..."
if command -v node >/dev/null 2>&1; then
    NODE_VERSION=$(node --version)
    print_ok "Node.js installed: $NODE_VERSION"
else
    print_error "Node.js not installed"
    echo "Install from: https://nodejs.org/"
fi

if command -v npm >/dev/null 2>&1; then
    NPM_VERSION=$(npm --version)
    print_ok "npm installed: $NPM_VERSION"
else
    print_error "npm not installed"
fi

# Check 2: Docker
print_check "Checking Docker..."
if command -v docker >/dev/null 2>&1; then
    DOCKER_VERSION=$(docker --version)
    print_ok "Docker installed: $DOCKER_VERSION"
    
    # Check if Docker daemon is running
    if docker info >/dev/null 2>&1; then
        print_ok "Docker daemon is running"
    else
        print_error "Docker daemon is not running"
        echo "Start Docker Desktop or run: sudo systemctl start docker"
    fi
else
    print_error "Docker not installed"
    echo "Install from: https://docs.docker.com/get-docker/"
fi

# Check 3: Git
print_check "Checking Git..."
if command -v git >/dev/null 2>&1; then
    GIT_VERSION=$(git --version)
    print_ok "Git installed: $GIT_VERSION"
else
    print_error "Git not installed"
fi

# Check 4: Project structure
print_check "Checking project structure..."
if [ -f "package.json" ]; then
    print_ok "package.json found"
else
    print_error "package.json not found - run from project root"
fi

if [ -f "app.js" ]; then
    print_ok "app.js found"
else
    print_warning "app.js not found"
fi

if [ -f "Dockerfile" ]; then
    print_ok "Dockerfile found"
else
    print_warning "Dockerfile not found"
fi

if [ -d ".git" ]; then
    print_ok "Git repository initialized"
else
    print_warning "Git repository not initialized - run 'git init'"
fi

# Check 5: Dependencies
print_check "Checking dependencies..."
if [ -d "node_modules" ]; then
    print_ok "node_modules directory exists"
else
    print_warning "node_modules not found - run 'npm install'"
fi

if [ -f "package-lock.json" ]; then
    print_ok "package-lock.json found"
else
    print_warning "package-lock.json not found - will be created on npm install"
fi

# Check 6: Git configuration
print_check "Checking Git configuration..."
if git config user.name >/dev/null 2>&1; then
    GIT_USER=$(git config user.name)
    print_ok "Git user.name: $GIT_USER"
else
    print_warning "Git user.name not set"
    echo "Set with: git config --global user.name 'Your Name'"
fi

if git config user.email >/dev/null 2>&1; then
    GIT_EMAIL=$(git config user.email)
    print_ok "Git user.email: $GIT_EMAIL"
else
    print_warning "Git user.email not set"
    echo "Set with: git config --global user.email 'your.email@example.com'"
fi

# Check 7: Remote repository
print_check "Checking Git remote..."
if git remote get-url origin >/dev/null 2>&1; then
    REMOTE_URL=$(git remote get-url origin)
    print_ok "Remote origin: $REMOTE_URL"
else
    print_warning "No remote origin set"
    echo "Set with: git remote add origin <your-repo-url>"
fi

# Check 8: Port availability
print_check "Checking port availability..."
if lsof -i :3000 >/dev/null 2>&1; then
    print_warning "Port 3000 is in use"
    echo "Stop the process or use a different port"
else
    print_ok "Port 3000 is available"
fi

if lsof -i :3001 >/dev/null 2>&1; then
    print_warning "Port 3001 is in use"
    echo "Stop the process or use a different port"
else
    print_ok "Port 3001 is available"
fi

echo ""
echo "🛠️  Quick Fix Commands:"
echo "======================"
echo "Install dependencies:     npm install"
echo "Run tests:               npm test"
echo "Start development:       npm run dev"
echo "Build Docker image:      docker build -t mern-app ."
echo "Run Docker container:    docker run -p 3000:3000 mern-app"
echo "Initialize Git:          git init"
echo "Add remote:              git remote add origin <url>"
echo "First commit:            git add . && git commit -m 'Initial commit'"
echo ""

# Test basic functionality
print_check "Running basic tests..."

if [ -f "package.json" ] && command -v npm >/dev/null 2>&1; then
    echo "Testing npm install..."
    if npm list >/dev/null 2>&1; then
        print_ok "npm dependencies are satisfied"
    else
        print_warning "npm dependencies need to be installed"
        echo "Run: npm install"
    fi
fi

echo ""
echo "✅ Troubleshooting completed!"
echo "If issues persist, check the error messages above."