pipeline {
    agent any

    environment {
        // Define any global environment variables here
        IMAGE_NAME = 'mygoapp'
        CONTAINER_NAME = 'mygoapp-instance'
        PORT = '8080'
    }

    stages {
        stage('Initialize') {
            steps {
                script {
                    echo 'Preparing environment'
                    // Any initialization or setup steps
                }
            }
        }

        stage('Checkout') {
            steps {
                checkout scm: [$class: 'GitSCM', userRemoteConfigs: [[url: 'https://github.com/phillipohwotemu/go_app2.git']], branches: [[name: '*/main']]]
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${env.IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove any previously running container to avoid conflicts
                    sh "docker rm -f ${env.CONTAINER_NAME} || true"
                    // Run the new Docker container, mapping the port to the host
                    sh "docker run -d --name ${env.CONTAINER_NAME} -p ${env.PORT}:${env.PORT} ${env.IMAGE_NAME}:latest"
                }
            }
        }

        // Add additional stages for testing, deployment, etc., as needed.
    }

    post {
        always {
            echo 'Pipeline execution complete.'
            // Cleanup: Stop and remove the Docker container
            sh "docker rm -f ${env.CONTAINER_NAME} || true"
        }
        // Implement any other post conditions like 'success', 'failure', etc., as needed.
    }
}

