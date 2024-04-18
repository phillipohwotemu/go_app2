pipeline {
    agent any

    environment {
        // Define your image name and other environment variables here
        IMAGE_NAME = 'mygoapp'
        CONTAINER_NAME = 'mygoapp-instance'
        DOCKER_PATH = '/usr/bin/docker' // Adjust this path based on where Docker is installed on your Jenkins host
    }

    stages {
        stage('Initialize') {
            steps {
                echo 'Preparing environment'
                // Prepare or clean up the environment before starting the build
            }
        }

        stage('Checkout SCM') {
            steps {
                checkout scm // Checks out source code from the configured repository
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    try {
                        sh "${env.DOCKER_PATH} build -t ${env.IMAGE_NAME}:latest ."
                    } catch (Exception e) {
                        echo "Failed to build Docker image: ${e.getMessage()}"
                        throw e // Rethrow to fail the stage
                    }
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    try {
                        sh "${env.DOCKER_PATH} run --rm ${env.IMAGE_NAME}:latest ./run-tests.sh"
                    } catch (Exception e) {
                        echo "Testing failed: ${e.getMessage()}"
                        throw e // Rethrow to indicate test failure
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    try {
                        sh "${env.DOCKER_PATH} rm -f ${env.CONTAINER_NAME} || true" // Ensure no previous instances are running
                        sh "${env.DOCKER_PATH} run -d --name ${env.CONTAINER_NAME} -p 80:80 ${env.IMAGE_NAME}:latest"
                    } catch (Exception e) {
                        echo "Deployment failed: ${e.getMessage()}"
                        throw e // Rethrow to indicate deployment failure
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                try {
                    sh "${env.DOCKER_PATH} stop ${env.CONTAINER_NAME} || true"
                    sh "${env.DOCKER_PATH} rm ${env.CONTAINER_NAME} || true"
                    sh "${env.DOCKER_PATH} rmi ${env.IMAGE_NAME}:latest || true"
                } catch (Exception e) {
                    echo "Error during cleanup: ${e.getMessage()}"
                }
                echo 'Pipeline execution complete.'
            }
        }
        success {
            echo 'Build and deployment succeeded!'
        }
        failure {
            echo 'Build or deployment failed.'
        }
    }
}

