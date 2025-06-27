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
            emailext (
                subject: "'${env.JOB_NAME}' Build #${env.BUILD_NUMBER} - Status: ${currentBuild.currentResult}",
                body: """<h2>Build Status Notification</h2>
                        <p><strong>Project:</strong> ${env.JOB_NAME}</p>
                        <p><strong>Build Number:</strong> ${env.BUILD_NUMBER}</p>
                        <p><strong>Status:</strong> ${currentBuild.currentResult}</p>
                        <p><strong>URL:</strong> <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>""",
                to: 'khaju452@gmail.com,unikhaja452@gmail.com',
                attachLog: true,
                compressLog: true
            )
        }
    }
}
