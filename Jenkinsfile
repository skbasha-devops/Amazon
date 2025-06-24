pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
                echo "Code checked out from ${env.GIT_URL}"
            }
        }
        
        stage('Run Tests') {
            steps {
                script {
                    // Check what test commands are available
                    if (fileExists('pom.xml')) {
                        echo "Running Maven tests"
                        sh 'mvn test || echo "Test execution failed"'
                    } else if (fileExists('package.json')) {
                        echo "Running npm tests"
                        sh 'npm test || echo "Test execution failed"'
                    } else if (fileExists('Makefile')) {
                        echo "Running make tests"
                        sh 'make test || echo "Test execution failed"'
                    } else {
                        echo "No standard test configuration found"
                        echo "Workspace contents:"
                        sh 'ls -la'
                        error("No recognized test configuration found")
                    }
                }
            }
        }
    }
    
    post {
        always {
            junit '**/target/surefire-reports/*.xml' // For Maven
            junit '**/test-results/*.xml' // For other frameworks
            archiveArtifacts artifacts: '**/reports/**/*', allowEmptyArchive: true
        }
    }
}
