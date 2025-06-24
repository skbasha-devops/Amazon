pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building deployment package'
                sh 'make package'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying to staging'
                sh 'make deploy-staging'
            }
        }
    }
}
