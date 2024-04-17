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
                    // Using sudo to run Docker commands
                    sh 'sudo docker build -t ${IMAGE_NAME}:latest .'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Using sudo to run Docker commands
                    sh 'sudo docker rm -f ${CONTAINER_NAME} || true'
                    sh 'sudo docker run -d --name ${CONTAINER_NAME} -p 8080:8080 ${IMAGE_NAME}:latest'
                }
            }
        }

        stage('Check Container Status') {
            steps {
                script {
                    sh 'sudo docker ps || true'
                    sh 'sudo docker logs ${CONTAINER_NAME} || true'
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution complete.'
            // Using sudo to run Docker commands
            sh 'sudo docker rm -f ${CONTAINER_NAME} || true'
        }
    }
}
