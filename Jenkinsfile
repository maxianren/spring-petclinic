pipeline {
    agent any
    environment {
        DOCKER = '/usr/local/bin/docker' // Replace with the correct path to the Docker binary on your Jenkins server
    }

    stages {
 	stage('Initialize'){
        	def dockerHome = tool 'myDocker'
        	env.PATH = "${dockerHome}/bin:${env.PATH}"
    	}
        stage('Prepare') {
            steps {
                script {
                    def dockerImage = docker.image('openjdk:17-jdk')
                    dockerImage.pull()
                    dockerImage.inside {
                        sh './mvnw clean install'
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
