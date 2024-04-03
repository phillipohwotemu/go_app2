pipeline {
    agent any

    // Define environment variables or stages as needed here

    stages {
        stage('Initialize') {
            steps {
                script {
                    // Initialize or setup steps, if any
                    echo 'Preparing environment'
                }
            }
        }

        stage('Checkout') {
            steps {
                // Checkout from the specific branch, ensuring we're using 'main'
                checkout scm: [$class: 'GitSCM', userRemoteConfigs: [[url: 'https://github.com/phillipohwotemu/go_app2.git']], branches: [[name: '*/main']]]
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the Dockerfile in the root directory
                    sh 'docker build -t mygoapp:latest .'
                }
            }
        }

        // Include additional stages like 'Test', 'Deploy', etc., as needed

    }

    post {
        always {
            // Actions to perform after the pipeline runs, like cleanup
            echo 'Pipeline execution complete.'
        }
    }
}

