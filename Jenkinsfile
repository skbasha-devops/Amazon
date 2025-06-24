pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building with tests'
                sh 'make'
            }
        }
        stage('Test') {
            steps {
                echo 'Running unit tests'
                sh 'make test'
            }
        }
    }
}
