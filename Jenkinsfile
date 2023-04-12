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
                    sh 'mvn clean install -DskipTests'
            }
        }

        stage('Static Analysis with SonarQube') {
            steps {
                script {
                    def scannerHome = tool 'SonarQube'
                    withSonarQubeEnv('SonarQube') {
                        nodejs(nodeJSInstallationName: 'NodeJS 14.x') {
                            sh "${scannerHome}/bin/sonar-scanner -Dsonar.login=sqa_0b53b8ba19a9c540794f92039898753f17458859 \
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
            sh 'java -Djava.awt.headless=true -jar target/spring-petclinic-3.0.0-SNAPSHOT.jar --server.port=8090 &'
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
