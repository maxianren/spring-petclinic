pipeline {
    agent any

    stages {
        stage('Prepare') {
            steps {
                script {
                    withEnv(["PATH+DOCKER=/usr/local/bin"]) {
                        def dockerImage = docker.image('openjdk:17-jdk')
                        dockerImage.pull()
                        dockerImage.inside {
                            sh './mvnw clean install -DskipTests'
                        }
                    }
                }
            }
        }
        // Include other stages like SonarQube analysis, etc.
    }

    post {
        always {
            deleteDir()
        }
    }
}
