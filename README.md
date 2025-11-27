# Flask CI/CD Pipeline

A complete CI/CD pipeline implementation for a Python Flask web application using Jenkins, Docker, and AWS EC2.

## Project Overview

This repository contains a fully automated CI/CD pipeline for a Flask web application. The pipeline handles building, testing, containerizing, and deploying the application to a staging environment.

## Features

- ✅ Flask application with health check endpoints
- ✅ Automated unit testing with PyTest
- ✅ Docker containerization
- ✅ Jenkins pipeline automation
- ✅ Deployment script for production
- ✅ Complete project scaffolding

## Technology Stack

- **Web Framework**: Flask (Python)
- **CI/CD**: Jenkins
- **Containerization**: Docker
- **Testing**: PyTest
- **Deployment**: AWS EC2
- **Scripting**: Bash

## Project Structure

```
flask-app/
├── app.py                    # Main Flask application
├── requirements.txt          # Python dependencies
├── Dockerfile               # Docker configuration
├── Jenkinsfile              # Jenkins pipeline definition
├── deploy.sh                # Deployment script
└── tests/                   # Test suite
    └── test_app.py
```

## Getting Started

### Prerequisites
- Python 3.11+
- Docker
- Jenkins
- Git

### Local Development
```bash
# Install dependencies
pip install -r requirements.txt

# Run the application
python app.py
```

### Testing
```bash
# Run tests
python -m pytest tests/
```

## CI/CD Pipeline

The Jenkins pipeline includes the following stages:
1. **Clone Repository** - Pulls the latest code
2. **Run Unit Tests** - Executes PyTest suite
3. **Build Docker Image** - Creates container image
4. **Push Docker Image** - Pushes to private registry
5. **Deploy to Staging** - Deploys to AWS EC2 instance

## Configuration

Environment variables in `Jenkinsfile`:
- `DOCKER_REGISTRY`: Your private Docker registry
- `IMAGE_NAME`: Docker image name
- `STAGING_SERVER`: Staging server IP
- `SSH_USER`: SSH user for deployment

## Deployment

The `deploy.sh` script handles production deployments:
```bash
./deploy.sh
```

## License

This project is licensed under the MIT License.
