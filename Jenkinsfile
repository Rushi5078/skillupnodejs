pipeline {
    agent any

    environment {
        IMAGE_NAME = 'skillupnodejs'    // Name of the Docker image
        PORT = '9595'                   // Port where the app will run
    }

    stages {
        stage('Checkout Repository') {
            steps {
                script {
                    // Clone the repository from GitHub
                    git 'https://github.com/yourusername/your-repository.git'
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

        stage('Stop Existing Containers') {
            steps {
                script {
                    // Stop and remove any running container with the same name
                    sh '''
                    docker ps -q --filter "name=${IMAGE_NAME}" | xargs -I {} docker stop {}
                    docker ps -a -q --filter "name=${IMAGE_NAME}" | xargs -I {} docker rm {}
                    '''
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container using the built image
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
