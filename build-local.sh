#!/bin/bash

# Local Build Script
# Build and test the application locally

echo "🔨 Local Build and Test"
echo "======================="

# Install dependencies
echo "📦 Installing dependencies..."
if [ -f "package-lock.json" ]; then
    npm ci
else
    npm install
fi

# Run tests
echo "🧪 Running tests..."
npm test

# Build Docker image
echo "🐳 Building Docker image..."
docker build -t mern-cicd-app:local .

# Test Docker container
echo "🔍 Testing Docker container..."
docker run -d -p 3001:3000 --name test-app mern-cicd-app:local
sleep 5

# Health check
if curl -f http://localhost:3001/api/health; then
    echo "✅ Build successful!"
else
    echo "❌ Build failed!"
    exit 1
fi

# Cleanup
docker stop test-app
docker rm test-app

echo "🎉 Local build completed successfully!"