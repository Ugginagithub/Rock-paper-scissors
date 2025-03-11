pipeline {
    agent any  // Runs on any available Jenkins agent

    environment {
        DOCKER_IMAGE = 'rps'
        CONTAINER_PORT = '8082'  // Set port to use for the Docker container
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout code from the GitHub repository
                echo 'Checking out code from GitHub'
                git branch: 'main', url: 'https://github.com/Ugginagithub/Rock-paper-scissors.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image from the Dockerfile
                    echo 'Building Docker image'
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }

        stage('Test Docker Image') {
            steps {
                script {
                    // Clean up any container using the port 8082
                    echo 'Cleaning up any existing containers using port ${CONTAINER_PORT}'
                    sh '''
                        docker ps -q --filter "ancestor=${DOCKER_IMAGE}" --filter "publish=${CONTAINER_PORT}:80" | xargs -r docker stop
                    '''
                    
                    // Run the Docker container and test it
                    echo 'Running the Docker container'
                    sh '''
                        docker run -d -p ${CONTAINER_PORT}:80 ${DOCKER_IMAGE}
                        sleep 5  # Wait for the container to start
                    '''

                    // Test if the server responds
                    echo 'Testing if the server is responding'
                    def response = sh(script: "curl -s -o /dev/null -w '%{http_code}' http://localhost:${CONTAINER_PORT}", returnStdout: true).trim()
                    if (response == '200') {
                        echo 'Server is responding correctly!'
                    } else {
                        error "Test failed. Server responded with HTTP code ${response}"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy the Docker container (for this example, we run it locally)
                    echo 'Deploying the Docker container'
                    sh 'docker run -d -p ${CONTAINER_PORT}:80 ${DOCKER_IMAGE}'
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
