pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Deploy Project') {
            steps {
                script {
                    // Change 'Amazon' to your project directory name
                    dir('Amazon') {
                        // For Maven projects
                        if (fileExists('pom.xml')) {
                            sh 'mvn deploy'
                        } 
                        // For Node.js projects
                        else if (fileExists('package.json')) {
                            sh 'npm install && npm deploy'
                        }
                        // For other projects
                        else {
                            error "No deploy configuration found in the project directory"
                        }
                    }
                }
            }
        }
    }
    
    post {
        always {
            // Collect deploy results if they exist
         junit testResults: '**/target/surefire-reports/*.xml,**/deploy-results/*.xml'
            
            // Clean up workspace
            cleanWs()
        }
    }
}

