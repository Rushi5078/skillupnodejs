pipeline {
    agent any

    environment {
        IMAGE_NAME = 'skillupnodejs'
        PORT = '9595'
    }

    stages {
        stage('Checkout Repository') {
            steps {
                script {
                    // Clone the repository from GitHub
                    git 'https://github.com/Rushi5078/skillupnodejs.git'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the Dockerfile in the repo
                    sh 'docker build -t ${IMAGE_NAME} .'
                }
            }
        }

        stage('Stop and Remove Existing Container') {
            steps {
                script {
                    // Stop and remove the existing container with the same name, if it's running
                    sh '''
                    CONTAINER_ID=$(docker ps -q -f name=${IMAGE_NAME})
                    if [ -n "$CONTAINER_ID" ]; then
                        echo "Stopping and removing existing container ${IMAGE_NAME}..."
                        docker stop ${IMAGE_NAME}
                        docker rm ${IMAGE_NAME}
                    fi
                    '''
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the new Docker container
                    sh 'docker run -d -p ${PORT}:${PORT} --name ${IMAGE_NAME} ${IMAGE_NAME}'
                }
            }
        }

        stage('Verify Application') {
            steps {
                script {
                    // Verify if the application is running by accessing the port
                    sh '''
                    curl --silent --fail http://localhost:${PORT} || echo "Application failed to start"
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully! Application is running.'
        }
        failure {
            echo 'Pipeline failed! Check the logs for errors.'
        }
    }
}
