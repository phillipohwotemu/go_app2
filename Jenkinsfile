pipeline {
    agent any

    environment {
        // Define any global environment variables here
        IMAGE_NAME = 'mygoapp'
        CONTAINER_NAME = 'mygoapp-instance'
        PORT = '8080'
    }

    stages {
        // Previous stages...

        stage('Run Docker Container') {
            steps {
                script {
                    // Attempt to stop and remove any previously running container to avoid conflicts
                    sh "docker rm -f ${env.CONTAINER_NAME} || true"

                    // Try to run the new Docker container, mapping the port to the host
                    sh "docker run -d --name ${env.CONTAINER_NAME} -p ${env.PORT}:${env.PORT} ${env.IMAGE_NAME}:latest"
                }
            }
        }

        // Subsequent stages...
    }

    post {
        always {
            echo 'Pipeline execution complete.'
        }
    }
}

