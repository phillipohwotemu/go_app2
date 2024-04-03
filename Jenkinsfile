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
                checkout scm: [$class: 'GitSCM', userRemoteConfigs: [[url: 
'https://github.com/phillipohwotemu/go_app2.git']], branches: [[name: '*/main']]]
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
                    // Attempt to stop and remove any previously running container to avoid conflicts
                    sh "docker rm -f ${env.CONTAINER_NAME} || true"

                    // Try to run the new Docker container, mapping the port to the host
                    // Include error handling to catch and display any issues during container startup
                    try {
                        sh "docker run -d --name ${env.CONTAINER_NAME} -p ${env.PORT}:${env.PORT} 
${env.IMAGE_NAME}:latest"
                    } catch (Exception e) {
                        echo "Failed to start Docker container: ${e.getMessage()}"
                        // Optionally, rethrow the exception to fail the build
                        // throw e
                    }
                }
            }
        }

        // Add additional stages for testing, deployment, etc., as needed.
    }

    post {
        always {
            echo 'Pipeline execution complete.'
            // Cleanup: Optionally, stop and remove the Docker container
            // sh "docker rm -f ${env.CONTAINER_NAME} || true"
        }
        // Implement any other post conditions like 'success', 'failure', etc., as needed.
    }
}

