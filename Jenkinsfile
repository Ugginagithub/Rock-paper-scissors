pipeline {
    agent any  // Runs on any available Jenkins agent

    environment {
        DOCKER_IMAGE = 'rps'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout code from the GitHub repository
                 git branch: 'main', url: 'https://github.com/Ugginagithub/Rock-paper-scissors.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image from the Dockerfile
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }

        stage('Test Docker Image') {
            steps {
                script {
                    // Run the Docker container and test it
                    sh '''
                        docker run -d -p 8080:80 ${DOCKER_IMAGE}
                        sleep 5  // Wait for the container to start
                        curl http://localhost:8080  // Test if the server responds
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy the Docker container (for this example, we run it locally)
                    sh 'docker run -d -p 8080:80 ${DOCKER_IMAGE}'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
