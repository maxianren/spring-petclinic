pipeline {
    agent {
        docker {
            image 'openjdk:17-jdk'
        }
    }

    stages {
        stage('Build') {
            steps {
                sh './mvnw clean install'
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
    }
    post {
        always {
            deleteDir()
        }
    }
}

