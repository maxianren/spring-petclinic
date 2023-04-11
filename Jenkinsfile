pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                withEnv(["JAVA_HOME=${tool 'OpenJDK-17'}"]) {
                    sh 'mvn clean install -DskipTests'
                }
        }

        stage('Static Analysis with SonarQube') {
            steps {
                script {
                    def scannerHome = tool 'SonarQube'
                    withSonarQubeEnv('SonarQube') {
                        sh "${scannerHome}/bin/sonar-scanner -Dsonar.login=sqa_c29f79fe99ec6b22cc7ed1cd1852b8baefb72a4a \
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
