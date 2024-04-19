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
            agent {
                docker {
                    image 'docker:19.03.12' // Use an appropriate Docker client image
                    args '-v /var/run/docker.sock:/var/run/docker.sock' // Mount the Docker daemon socket
                }
            }
            steps {
                script {
                    sh "docker build -t ${env.IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Test') {
            agent {
                docker {
                    image "${env.IMAGE_NAME}:latest"
                }
            }
            steps {
                sh "./run-tests.sh"
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh "docker rm -f ${env.CONTAINER_NAME} || true" // Ensure no previous instances are running
                    sh "docker run -d --name ${env.CONTAINER_NAME} -p 80:80 ${env.IMAGE_NAME}:latest"
                }
            }
        }
    }

    post {
        always {
            script {
                sh "docker stop ${env.CONTAINER_NAME} || true"
                sh "docker rm ${env.CONTAINER_NAME} || true"
                sh "docker rmi ${env.IMAGE_NAME}:latest || true"
            }
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
