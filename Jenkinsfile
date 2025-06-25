pipeline {
    agent any  // ← THIS IS REQUIRED
    
    stages {
        stage('Build') {
            steps {
                echo "Building branch ${env.BRANCH_NAME}"
                // Your build commands here
            }
        }
        stage('Test') {
            steps {
                echo "Testing branch ${env.BRANCH_NAME}"
                // Your test commands here
            }
        }
    }
}
