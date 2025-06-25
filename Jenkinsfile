// Add this to your Jenkinsfile
pipeline {
    stages {
        stage('PR Build') {
            when { 
                changeRequest()  // Critical for PR detection
            }
            steps {
                echo "Building PR #${env.CHANGE_ID} from ${env.CHANGE_BRANCH}"
                // PR-specific build steps
            }
        }
    }
}
