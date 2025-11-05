#!/bin/bash

# Local Build and Test Only Script
# This script builds and tests locally without pushing to GitHub or Docker Hub

echo "🔨 Local Build and Test (No Push)"
echo "================================="

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Exit on any error
set -e

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    print_error "package.json not found. Please run this script from the project root."
    exit 1
fi

print_status "Starting local build process..."

# Clean up ports
print_status "🧹 Cleaning up ports..."
chmod +x cleanup-ports.sh
./cleanup-ports.sh

# Step 1: Install dependencies
print_status "📦 Installing dependencies..."
if [ -f "package-lock.json" ]; then
    npm ci
else
    npm install
fi

print_success "Dependencies installed successfully"

# Step 2: Run tests
print_status "🧪 Running tests..."
npm test
print_success "All tests passed!"

# Step 3: Build Docker image locally
print_status "🐳 Building Docker image locally..."
docker build -t mern-cicd-app:local .
print_success "Docker image built successfully"

# Step 4: Test Docker container locally
print_status "🔍 Testing Docker container locally..."
docker run -d -p 3001:3000 --name local-test-container mern-cicd-app:local

# Wait for container to start
sleep 5

# Test the health endpoint
if curl -f http://localhost:3001/api/health >/dev/null 2>&1; then
    print_success "Local Docker container test passed"
    
    # Show some test results
    echo ""
    echo "📊 Test Results:"
    echo "Health endpoint: ✅ http://localhost:3001/api/health"
    echo "Main endpoint: ✅ http://localhost:3001/"
    echo "Users endpoint: ✅ http://localhost:3001/api/users"
    
    # Test all endpoints
    print_status "Testing all endpoints..."
    echo "🔍 GET /"
    curl -s http://localhost:3001/ | head -c 100
    echo ""
    echo "🔍 GET /api/health"
    curl -s http://localhost:3001/api/health
    echo ""
    echo "🔍 GET /api/users"
    curl -s http://localhost:3001/api/users | head -c 150
    echo ""
    
else
    print_error "Local Docker container test failed"
    docker logs local-test-container
    exit 1
fi

# Clean up
print_status "🧹 Cleaning up test container..."
docker stop local-test-container >/dev/null 2>&1
docker rm local-test-container >/dev/null 2>&1

echo ""
print_success "🎉 Local build and test completed successfully!"
echo ""
echo "📋 Summary:"
echo "✅ Dependencies installed"
echo "✅ Tests passed"
echo "✅ Docker image built"
echo "✅ Container tested locally"
echo ""
echo "🚀 Next steps:"
echo "1. Push to GitHub: ./build-and-push.sh"
echo "2. Set up Docker Hub secrets for full CI/CD"
echo "3. Run full pipeline: ./run-pipeline.sh"
echo ""
echo "🐳 Local Docker image: mern-cicd-app:local"
echo "Run locally: docker run -p 3000:3000 mern-cicd-app:local"