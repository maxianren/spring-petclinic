pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Deploy') {
            steps {
                sh 'ansible-playbook -i inventory.ini deploy_petclinic.yml'
            }
        }
    }
}
