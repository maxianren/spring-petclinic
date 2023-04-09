pipeline {
    agent {
        docker {
            image 'docker'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    stages {
        stage('Prepare') {
            steps {
                script {
                    def dockerImage = docker.image('openjdk:17-jdk')
                    dockerImage.pull()
                    dockerImage.inside {
                        sh './mvnw clean install -DskipTests'
                    }
                }
            }
        }
        stage('Static Analysis with SonarQube') {
            steps {
                script {
                    def scannerHome = tool 'SonarQube Scanner';
                    withSonarQubeEnv('PetclinicSQ') {
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }
        // Add other stages as needed
    }

    post {
        always {
            deleteDir()
        }
    }
}
