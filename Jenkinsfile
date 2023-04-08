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

                script {
                    stage('Prepare') {
                        echo 'Preparing...'
                        // Your preparation steps here
                    }
                }

                script {
                    stage('Static Analysis with SonarQube') {
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
