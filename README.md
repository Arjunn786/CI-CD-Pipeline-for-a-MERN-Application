# MERN CI/CD Pipeline Project

A complete CI/CD pipeline implementation for a MERN application using GitHub Actions and Docker Hub.

## 🚀 Features

- **Express.js Backend**: Simple REST API with multiple endpoints
- **Automated Testing**: Jest-based test suite with API endpoint testing
- **Docker Containerization**: Multi-stage Docker build with security best practices
- **CI/CD Pipeline**: GitHub Actions workflow for automated testing, building, and deployment
- **Docker Hub Integration**: Automatic image pushing to Docker Hub registry

## 📁 Project Structure

```
├── .github/
│   └── workflows/
│       └── ci-cd.yml          # GitHub Actions workflow
├── test/
│   └── app.test.js            # API tests
├── app.js                     # Main Express application
├── package.json               # Dependencies and scripts
├── Dockerfile                 # Container configuration
├── .dockerignore              # Docker ignore rules
├── healthcheck.js             # Container health check
└── README.md                  # Project documentation
```

## 🛠️ API Endpoints

- `GET /` - Welcome message with timestamp
- `GET /api/health` - Health check endpoint
- `GET /api/users` - Sample users data

## 🐳 Docker Usage

### Build locally
```bash
docker build -t mern-cicd-app .
```

### Run locally
```bash
docker run -p 3000:3000 mern-cicd-app
```

### Pull from Docker Hub
```bash
docker pull <your-dockerhub-username>/mern-cicd-app:latest
docker run -p 3000:3000 <your-dockerhub-username>/mern-cicd-app:latest
```

## 🔧 Local Development

### Prerequisites
- Node.js 18+
- npm or yarn
- Docker (optional)

### Setup
```bash
# Clone the repository
git clone <your-repo-url>
cd CI-CD-Pipeline-for-a-MERN-Application

# Install dependencies
npm install

# Run in development mode
npm run dev

# Run tests
npm test

# Run production mode
npm start
```

## ⚙️ CI/CD Pipeline

The GitHub Actions workflow automatically:

1. **Tests**: Runs Jest test suite
2. **Build**: Creates Docker image with multi-platform support
3. **Push**: Uploads image to Docker Hub
4. **Verify**: Pulls and tests the deployed image

### Required GitHub Secrets

Set these in your GitHub repository settings:

- `DOCKER_HUB_USERNAME` - Your Docker Hub username
- `DOCKER_HUB_ACCESS_TOKEN` - Your Docker Hub access token

## 🔒 Security Features

- Non-root user in Docker container
- Minimal base image (Alpine Linux)
- Production-only dependencies in final image
- Health checks for container monitoring
- Comprehensive .dockerignore for smaller images

## 📊 Testing

The project includes comprehensive API testing:

- Endpoint response validation
- Status code verification
- JSON structure testing
- Error handling validation

Run tests with:
```bash
npm test
```

## 🚀 Deployment

The application automatically deploys to Docker Hub when code is pushed to the main branch. The workflow:

1. Triggers on push to main/master
2. Runs all tests
3. Builds Docker image (if tests pass)
4. Pushes to Docker Hub
5. Verifies deployment

## 📝 Environment Variables

- `PORT` - Server port (default: 3000)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new features
5. Ensure all tests pass
6. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

## 🔗 Links

- GitHub Repository: [Your GitHub Repo URL]
- Docker Hub Repository: [Your Docker Hub Repo URL]
- Live Demo: [Your deployed app URL if applicable]
## 🌿 Current Branch
This commit was made on branch: `feature/cicd-pipeline-setup`
Timestamp: Wed Nov  5 13:36:01 IST 2025
