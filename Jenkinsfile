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
                    sh 'docker build -t ${IMAGE_NAME}:latest .'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Attempt to remove any previously running container to avoid name conflicts
                    sh 'docker rm -f ${CONTAINER_NAME} || true'
                    
                    // Attempt to start a new container
                    sh 'docker run -d --name ${CONTAINER_NAME} -p 8080:8080 ${IMAGE_NAME}:latest'
                }
            }
        }

        stage('Check Container Status') {
            steps {
                script {
                    // Wait briefly to allow the container to start up
                    sh 'sleep 5'
                    
                    // Check if the container is running
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
            sh 'docker rm -f ${CONTAINER_NAME} || true'
        }
    }
}
