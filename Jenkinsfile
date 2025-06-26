pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                echo "Building the application..."
            }
        }
    }
    
    post {
        always {
            script {
                // Debug output to verify variables
                echo "JOB_NAME: ${env.JOB_NAME}"
                echo "BUILD_URL: ${env.BUILD_URL}"
                
                // Force email sending with minimal configuration
                emailext (
                    subject: "TEST: ${env.JOB_NAME} Build Notification",
                    body: "This is a test email from Jenkins.\nBuild URL: ${env.BUILD_URL}",
                    to: 'khaju452@gmail.com',  // Use your actual email
                    recipientProviders: [],
                    mimeType: 'text/plain'
                )
            }
        }
    }
}
