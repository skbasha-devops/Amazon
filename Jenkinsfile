pipeline {
    agent any

    stages {
        stage('Build new') {
            steps {
                echo 'Running build...'
            }
        }
    }

    post {
        always {
            emailext(
                subject: "Build ${currentBuild.currentResult}: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
                <p><b>Build Result:</b> ${currentBuild.currentResult}</p>
                <p><b>Job:</b> ${env.JOB_NAME}</p>
                <p><b>Build Number:</b> ${env.BUILD_NUMBER}</p>
                <p><b>Build URL:</b> <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>
                """,
                to: 'abcbatch11@gmail.com'
            )
        }
    }
}
