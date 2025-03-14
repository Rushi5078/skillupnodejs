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
                    deleteDir() // Clean workspace
                    git branch: 'master', url: 'https://github.com/Rushi5078/skillupnodejs.git'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t ${IMAGE_NAME} .'
                }
            }
        }

        stage('Stop and Remove Existing Container') {
            steps {
                script {
                    sh '''
                    CONTAINER_ID=$(docker ps -q -f name=${IMAGE_NAME})
                    if [ -n "$CONTAINER_ID" ]; then
                        echo "Stopping and removing existing container ${IMAGE_NAME}..."
                        docker stop $CONTAINER_ID
                        docker rm $CONTAINER_ID
                    fi
                    '''
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    sh 'docker run -d -p ${PORT}:${PORT} --name ${IMAGE_NAME} ${IMAGE_NAME}'
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
