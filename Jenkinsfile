pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Static Analysis with SonarQube') {
            steps {
                script {
                    def scannerHome = tool 'SonarQube'
                    withSonarQubeEnv('SonarQube') {
                        sh "${scannerHome}/bin/sonar-scanner -Dsonar.login=sqa_deb6ea5d8b8977e384505196373032b6e137cf08 \
			-Dsonar.projectKey=mycompany:myproject \
			-Dsonar.java.binaries=target/classes"
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
