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
                subject: "'${env.JOB_NAME}' Build #${env.BUILD_NUMBER} - Result: ${currentBuild.currentResult}",
                body: """<h2>Build Status Notification</h2>
                        <p><strong>Project:</strong> ${env.JOB_NAME}</p>
                        <p><strong>Build Number:</strong> ${env.BUILD_NUMBER}</p>
                        <p><strong>Status:</strong> ${currentBuild.currentResult}</p>
                        <p><strong>Duration:</strong> ${currentBuild.durationString}</p>
                        <p><a href="${env.BUILD_URL}">View Build Details</a></p>
                        ${CHANGES, showPaths=true, format="<h3>Changes:</h3><ul>%a: %m</ul>"}""",
                to: 'khaju452@gmail.com,unkhaju452@gmail.com',
                replyTo: 'khaju452@gmail.com',
                attachLog: true,
                compressLog: true
            )
        }
    }
}
