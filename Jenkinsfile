pipeline {
    agent any

    environment {
        IMAGE_NAME = 'mygoapp'
        CONTAINER_NAME = 'mygoapp-instance'
    }

    stages {
        stage('Initialize') {
            steps {
                script {
                    echo 'Preparing environment'
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
                    // Using Docker Pipeline plugin to build the image
                    docker.build("${IMAGE_NAME}:latest")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove any existing container
                    sh 'docker rm -f ${CONTAINER_NAME} || true'
                    
                    // Start the Docker container using the Docker Pipeline plugin
                    def app = docker.image("${IMAGE_NAME}:latest")
                    app.run("-d --name ${CONTAINER_NAME} -p 8080:8080")
                }
            }
        }

        stage('Check Container Status') {
            steps {
                script {
                    // Check if the container is running using the Docker Pipeline plugin
                    sh 'docker ps || true'
                    
                    // Output the logs of the container, useful for debugging startup issues
                    sh 'docker logs ${CONTAINER_NAME} || true'
                }
            }
        }
    }

    post {
        always {
            // Actions to perform after the pipeline runs, like cleanup
            echo 'Pipeline execution complete.'
            // Optionally remove the container after inspection
            // sh 'docker rm -f ${CONTAINER_NAME} || true'
        }
    }
}
