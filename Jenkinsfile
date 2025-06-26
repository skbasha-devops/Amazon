pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                // Your build steps here
                echo "Building the application..."
            }
        }
    }
    
    post {
        always {
            emailext (
                subject: "'${env.JOB_NAME}' (${env.BUILD_NUMBER}) - BUILD ${currentBuild.currentResult}",
                body: """<p>Build Status: <strong>${currentBuild.currentResult}</strong></p>
                        <p>Project: ${env.JOB_NAME}</p>
                        <p>Build Number: ${env.BUILD_NUMBER}</p>
                        <p>Build URL: <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>
                        <p>Commit Message: ${env.GIT_COMMIT_MESSAGE ?: 'N/A'}</p>""",
                to: 'devops-team@jenkins.com',
                recipientProviders: [[$class: 'DevelopersRecipientProvider']],
                attachLog: true,
                compressLog: true
            )
        }
        
        success {
            echo "This will run only if successful"
        }
        
        failure {
            echo "This will run only if failed"
        }
    }
}
