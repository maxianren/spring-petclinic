pipeline {
    agent any

    stages {
        stage('Prepare') {
    steps {
        script {
            def dockerTool = tool 'myDocker'
            withEnv(["PATH+DOCKER=${dockerTool}/bin"]) {
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
