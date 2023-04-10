pipeline {
    agent none

    stages {
        stage('Prepare') {
            agent {
                docker {
                    build 'openjdk-custom'
                }
            }
            steps {
                sh './mvnw clean install'
            }
        }
        stage('Static Analysis with SonarQube') {
            agent any
            steps {
                script {
                    def scannerHome = tool 'SonarQube Scanner'
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
