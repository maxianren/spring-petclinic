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
            sh 'docker build -t petclinic .'
            sh 'docker run -d -p 8090:8090 --name petclinic petclinic'
            timeout(time: 1, unit: 'MINUTES') {
                waitUntil {
                    script {
                        def result = sh(script: 'curl --silent --fail http://172.19.0.3:8090', returnStatus: true)
                        return (result == 0)
                    }
                }
            }
        }
    }
}





    }

}
