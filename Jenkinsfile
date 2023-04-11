pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                withEnv(["JAVA_HOME=${tool 'OpenJDK-17'}"]) {
                    sh 'mvn clean install -DskipTests'
                }
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
        stage('Run PetClinic') {
            steps {
                withEnv(["JAVA_HOME=${tool 'OpenJDK-17'}"]) {
                    sh 'java -jar target/spring-petclinic-3.0.0-SNAPSHOT.jar &'
                    timeout(time: 1, unit: 'MINUTES') {
                        waitUntil {
                            script {
                                def result = sh(script: 'curl --silent --fail http://localhost:8080', returnStatus: true)
                                return (result == 0)
                            }
                        }
                    }
                }
            }
        }
    }
    post {
        always {
            sh 'pkill -f spring-petclinic'
            deleteDir()
        }
    }
}
