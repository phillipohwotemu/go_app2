pipeline {
    agent any

    environment {
        // Define your image name and other environment variables here
        IMAGE_NAME = 'mygoapp'
        CONTAINER_NAME = 'mygoapp-instance'
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
                    // Build the Docker image using the Dockerfile in the repository
                    sh "docker build -t ${env.IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run tests here; for simplicity, using docker run to execute tests
                    sh "docker run --rm ${env.IMAGE_NAME}:latest ./run-tests.sh"
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy the container to a staging or production environment
                    // This example assumes a simple docker run could be a deployment
                    sh "docker rm -f ${env.CONTAINER_NAME} || true" // Ensure no previous instances are running
                    sh "docker run -d --name ${env.CONTAINER_NAME} -p 80:80 ${env.IMAGE_NAME}:latest"
                }
            }
        }
    }

    post {
        always {
            // Clean up Docker images after the pipeline runs
            sh "docker rmi ${env.IMAGE_NAME}:latest"
            echo 'Pipeline execution complete.'
        }
        success {
            echo 'Build and deployment succeeded!'
        }
        failure {
            echo 'Build or deployment failed.'
        }
    }
}
