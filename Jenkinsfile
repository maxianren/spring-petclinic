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
                            sh "${scannerHome}/bin/sonar-scanner -Dsonar.login=sqa_0b53b8ba19a9c540794f92039898753f17458859 \
                            -Dsonar.projectKey=mycompany:myproject \
                            -Dsonar.java.binaries=target/classes"
                        }
                    }
                }
            }
        }
stage('Run PetClinic') {
    steps {
        script {
            def appImage = docker.build('petclinic', 'target')
            docker.withRegistry('', 'docker-credentials') {
                appImage.push()
            }
            appImage.run('-p 8090:8090 --name petclinic').inside('-u root') {
                sh 'java -Djava.awt.headless=true -jar /app/target/spring-petclinic-3.0.0-SNAPSHOT.jar --server.port=8090'
            }
        }
    }
}



    }

}
