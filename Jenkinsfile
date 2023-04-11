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
                            sh "${scannerHome}/bin/sonar-scanner -Dsonar.login=sqa_3ee354eba574d5d565617d1f905fa695084b350e \
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
        sh 'pkill -f spring-petclinic || true'
        deleteDir()
    }
}
}
