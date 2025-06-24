pipeline {
    agent any
    stages {
        stage('Build & Deploy') {
            steps {
                dir('Amazon') {
                    sh 'mvn clean package deploy -DskipTests'  // For Maven
                    // OR
                    sh 'make package && make deploy-staging'   // For Make
                }
            }
        }
    }
}
