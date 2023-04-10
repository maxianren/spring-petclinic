pipeline {
    agent any

    stages {
        stage('Prepare') {
            steps {
                sh 'docker pull openjdk:17-jdk'
                sh '''
                    docker run --rm -v $(pwd):/workspace -w /workspace openjdk:17-jdk /bin/sh -c "./mvnw clean install"
                '''
            }
        }
        stage('Static Analysis with SonarQube') {
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