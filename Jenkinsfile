pipeline {
    agent any

    environment {
        IMAGE_NAME = 'mygoapp'
        CONTAINER_NAME = 'mygoapp-instance'
    }

    stages {
        stage('Initialize') {
            steps {
                echo 'Preparing environment'
            }
        }

        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the Docker CLI installed in the Jenkins container
                    sh "docker build -t ${env.IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // First, try to remove a previously running container if it exists
                    sh "docker rm -f ${env.CONTAINER_NAME} || true"
                    // Run a new instance of the Docker container
                    sh "docker run -d --name ${env.CONTAINER_NAME} ${env.IMAGE_NAME}:latest"
                }
            }
        }

        stage('Check Container Status') {
            steps {
                script {
                    // Check the status of the Docker container
                    sh "docker ps"
                }
            }
        }
    }

    post {
        always {
            // Clean up Docker container after the job is done
            sh "docker rm -f ${env.CONTAINER_NAME} || true"
            echo 'Pipeline execution complete.'
        }
    }
}
