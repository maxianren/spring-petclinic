pipeline {
    agent none

    stages {
        stage('Checkout') {
            agent any
            steps {
                checkout scm
            }
        }

        stage('Docker Build and Test') {
            agent {
                docker {
                    image 'openjdk:17-jdk'
                    args '-v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                echo 'Inside Docker container'

                stage('Prepare') {
                    steps {
                        echo 'Preparing...'
                        // Your preparation steps here
                    }
                }

                stage('Static Analysis with SonarQube') {
                    steps {
                        echo 'Running SonarQube analysis...'
                        // Your SonarQube steps here
                    }
                }
            }
        }
    }

    post {
        always {
            deleteDir()
        }
    }
}
