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
                        nodejs(nodeJSInstallationName: 'NodeJS 14.x') {
                            sh "${scannerHome}/bin/sonar-scanner -Dsonar.login=sqa_24d5e6d1508a98afb6818efdcb23759c57535d20 \
                            -Dsonar.projectKey=mycompany:myproject \
                            -Dsonar.java.binaries=target/classes \
                	-Dsonar.file.ignoreFiles=50 \
                	-Dsonar.java.libraries=target/lib/**/*.jar \
                	-Dsonar.sourceEncoding=UTF-8"
                        }
                    }
                }
            }
        }
stage('Run PetClinic') {
    steps {
        withEnv(["JAVA_HOME=${tool 'OpenJDK-17'}", "PATH=${tool 'OpenJDK-17'}/bin:$PATH"]) {
            sh 'java -jar target/spring-petclinic-3.0.0-SNAPSHOT.jar --server.port=8090 &'
            timeout(time: 1, unit: 'MINUTES') {
                waitUntil {
                    script {
                        def result = sh(script: 'curl --silent --fail http://localhost:8090', returnStatus: true)
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
        sh 'pkill -f spring-petclinic || true'
        deleteDir()
    }
}
}
