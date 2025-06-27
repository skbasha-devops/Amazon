pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                echo "Building..."
            }
        }
    }
    
    post {
        always {
            script {
                try {
                    emailext(
                        subject: "$JOB_NAME - Build # $BUILD_NUMBER - $currentBuild.currentResult",
                        body: """
                            <p>Build Status: <b>$currentBuild.currentResult</b></p>
                            <p>Project: $JOB_NAME</p>
                            <p>Build #: $BUILD_NUMBER</p>
                            <p>URL: <a href="$BUILD_URL">$BUILD_URL</a></p>
                            ${CHANGES, showPaths=true}
                        """,
                        to: 'khaju452@gmail.com',
                        replyTo: '$DEFAULT_REPLYTO',
                        attachLog: true
                    )
                } catch (Exception e) {
                    echo "Failed to send email: ${e.toString()}"
                }
            }
        }
    }
}
