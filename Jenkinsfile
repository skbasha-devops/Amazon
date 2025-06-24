pipeline {
    agent any
    stages {
        stage('feature1.0') {
            steps {
                echo 'Running basic build'
                script {
                    try {
                        sh 'make --version' // Check if make exists
                        sh 'make'
                    } catch (Exception e) {
                        echo 'Make not found, using alternative build method'
                        // Add alternative build commands here
                        sh 'mvn clean install' // Example for Java projects
                        // or sh 'npm install && npm run build' for Node.js
                    }
                }
            }
        }
    }
}
