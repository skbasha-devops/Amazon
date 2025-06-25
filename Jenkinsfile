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

    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
                echo "Successfully checked out code from ${env.GIT_URL}"

            }
        }
        
        stage('Build') {
            steps {
                script {
                    // Simple build steps that work on most Jenkins environments
                    echo "Checking what build tools are available..."
                    
                    // Check for common build files
                    if (fileExists('pom.xml')) {
                        echo "Found Maven project"
                        sh 'mvn --version || echo "Maven not installed"'
                    } else if (fileExists('build.gradle')) {
                        echo "Found Gradle project"
                        sh 'gradle --version || echo "Gradle not installed"'
                    } else if (fileExists('Makefile')) {
                        echo "Found Makefile"
                        sh 'make --version || echo "Make not installed"'
                    } else {
                        echo "No standard build files found"
                        echo "Contents of workspace:"
                        sh 'ls -la'
                    }
                }
            }
        }
        
        stage('Results') {
            steps {
                echo "Build process completed"
                echo "Workspace: ${env.WORKSPACE}"
            }
        }
    }
    
    post {
        always {
            echo "Pipeline finished - ${currentBuild.result}"
        }
        success {
            echo "Build succeeded!"
        }
        failure {
            echo "Build failed - please check console output"
        }
    }
}
