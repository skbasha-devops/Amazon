pipeline {
    agent any
    
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
                echo "Checked out code from ${env.GIT_URL}"
            }
        }
        
        stage('Run Tests') {
            steps {
                script {
                    // Simple test command - modify this for your project
                    try {
                        if (fileExists('pom.xml')) {
                            sh 'mvn test'
                        } else if (fileExists('package.json')) {
                            sh 'npm install && npm test'
                        } else {
                            echo "No test configuration found"
                            echo "Workspace contents:"
                            sh 'ls -la'
                            error("No test configuration found")
                        }
                    } catch (Exception e) {
                        error("Tests failed: ${e.getMessage()}")
                    }
                }
            }
        }
    }
    
    post {
        always {
            echo "Test stage completed"
            // Simple test results collection (won't fail if no reports exist)
            junit allowEmptyResults: true, testResults: '**/test-results/*.xml'
        }
    }
}
