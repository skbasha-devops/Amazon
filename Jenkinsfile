pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                // Your build steps here
            }
        }
    }
    post {
        always {
            emailext (
                subject: "Build ${currentBuild.currentResult}: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """<p>Build ${currentBuild.currentResult}</p>
                        <p>Project: ${env.JOB_NAME}</p>
                        <p>Build Number: ${env.BUILD_NUMBER}</p>
                        <p>Build URL: ${env.BUILD_URL}</p>
                        <p>Duration: ${currentBuild.durationString}</p>""",
                to: 'khaju452@gmail.com',
                attachLog: true
            )
        }
        success {
            emailext (
                subject: "SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                to: 'khaju452@gmail.com',
                body: "The build succeeded!\n\n${env.BUILD_URL}"
            )
        }
        failure {
            emailext (
                subject: "FAILED: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                to: 'khaju452@gmail.com,engineering-managers@yourdomain.com',
                body: "The build failed!\n\nSee ${env.BUILD_URL}",
                attachLog: true
            )
        }
    }
}
