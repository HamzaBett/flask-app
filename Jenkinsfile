pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY = 'your-registry.io'
        IMAGE_NAME = 'flask-app'
        CONTAINER_NAME = 'flask-app-container'
        STAGING_SERVER = 'staging-server-ip'
        SSH_USER = 'ubuntu'
    }
    
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/yourusername/flask-app.git'
            }
        }
        
        stage('Run Unit Tests') {
            steps {
                sh '''
                    python -m pytest tests/ --cov=app
                '''
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${env.DOCKER_REGISTRY}/${env.IMAGE_NAME}:${env.BUILD_ID}")
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry("https://${env.DOCKER_REGISTRY}", 'docker-registry-credentials') {
                        docker.image("${env.DOCKER_REGISTRY}/${env.IMAGE_NAME}:${env.BUILD_ID}").push()
                    }
                }
            }
        }
        
        stage('Deploy to Staging') {
            steps {
                sshagent(['staging-server-ssh']) {
                    sh '''
                        ssh ${SSH_USER}@${STAGING_SERVER} "
                            docker pull ${DOCKER_REGISTRY}/${IMAGE_NAME}:${BUILD_ID}
                            docker stop ${CONTAINER_NAME} || true
                            docker rm ${CONTAINER_NAME} || true
                            docker run -d --name ${CONTAINER_NAME} -p 5000:5000 ${DOCKER_REGISTRY}/${IMAGE_NAME}:${BUILD_ID}
                        "
                    '''
                }
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline completed successfully!'
            slackSend channel: '#ci-cd', message: "Deployment successful: ${env.BUILD_DISPLAY_NAME} deployed to staging"
        }
        failure {
            echo 'Pipeline failed!'
            slackSend channel: '#ci-cd', message: "Deployment failed: ${env.BUILD_DISPLAY_NAME}"
        }
    }
}
