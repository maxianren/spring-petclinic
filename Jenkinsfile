pipeline {
    agent any

    stages {
        stage('Prepare') {
            steps {
                script {
                    docker.withTool('myDocker') {
                        def dockerImage = docker.image('openjdk:17-jdk')
                        dockerImage.pull()
                        dockerImage.inside {
                            sh './mvnw clean install -DskipTests'
                        }
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
    }
    post {
        always {
            deleteDir()
        }
    }
}
