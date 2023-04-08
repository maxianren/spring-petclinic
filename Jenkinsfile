pipeline {
    agent any

    stages {
        stage('Prepare') {
            steps {
                script {
                    sh 'docker pull openjdk:17-jdk'
                    sh 'docker run --rm -v $(pwd):/app -w /app openjdk:17-jdk ./mvnw clean install'
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
    }
    post {
        always {
            deleteDir()
        }
    }
}
