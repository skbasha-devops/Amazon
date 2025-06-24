pipeline {
    agent any
    
    environment {
        // Define environment variables for deployment
        DEPLOY_ENV = 'staging'  // Can be 'staging' or 'production'
        ARTIFACT_NAME = 'app-${BUILD_NUMBER}.jar'  // Example artifact name
    }
    
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
                    echo "Checking build tools..."
                    
                    if (fileExists('pom.xml')) {
                        echo "Building Maven project"
                        sh 'mvn clean package -DskipTests'
                        // Store the built artifact
                        stash includes: 'target/*.jar', name: 'app-artifact'
                    } else if (fileExists('build.gradle')) {
                        echo "Building Gradle project"
                        sh 'gradle build -x test'
                        stash includes: 'build/libs/*.jar', name: 'app-artifact'
                    } else if (fileExists('Makefile')) {
                        echo "Building with Make"
                        sh 'make build'
                        // Adjust the stash pattern based on your Makefile output
                        stash includes: 'bin/*', name: 'app-artifact'
                    } else {
                        error "No recognized build configuration found"
                    }
                }
            }
        }
        
        stage('Test') {
            steps {
                script {
                    echo "Running tests..."
                    // Example test commands - adjust based on your project
                    if (fileExists('pom.xml')) {
                        sh 'mvn test'
                    } else if (fileExists('build.gradle')) {
                        sh 'gradle test'
                    }
                }
            }
        }
        
        stage('Deploy to Staging') {
            when {
                expression { env.DEPLOY_ENV == 'staging' }
            }
            steps {
                script {
                    echo "Deploying to staging environment..."
                    unstash 'app-artifact'
                    
                    // Example deployment commands - customize for your environment
                    if (fileExists('deploy/staging.sh')) {
                        sh 'chmod +x deploy/staging.sh && ./deploy/staging.sh'
                    } else if (fileExists('docker-compose.yml')) {
                        sh 'docker-compose up -d --build'
                    } else {
                        echo "No specific staging deployment configuration found"
                        // Fallback deployment option
                        sh "java -jar target/*.jar &"  // Simple run for demonstration
                    }
                }
            }
        }
        
        stage('Deploy to Production') {
            when {
                expression { env.DEPLOY_ENV == 'production' }
                beforeInput true
            }
            steps {
                script {
                    // Require manual approval for production deployment
                    input message: 'Deploy to production?', ok: 'Deploy'
                    
                    echo "Deploying to production environment..."
                    unstash 'app-artifact'
                    
                    // Example production deployment - customize for your environment
                    if (fileExists('deploy/production.sh')) {
                        sh 'chmod +x deploy/production.sh && ./deploy/production.sh'
                    } else if (fileExists('kubernetes/deployment.yaml')) {
                        sh 'kubectl apply -f kubernetes/deployment.yaml'
                    } else {
                        error "No production deployment configuration found"
                    }
                }
            }
        }
    }
    
    post {
        always {
            echo "Pipeline finished - ${currentBuild.result}"
            // Clean up workspace
            cleanWs()
        }
        success {
            echo "Pipeline succeeded!"
            // Optional: Notify success (Slack, email, etc.)
            // slackSend color: 'good', message: "Pipeline succeeded: ${env.JOB_NAME} ${env.BUILD_NUMBER}"
        }
        failure {
            echo "Pipeline failed - please check console output"
            // Optional: Notify failure
            // slackSend color: 'danger', message: "Pipeline failed: ${env.JOB_NAME} ${env.BUILD_NUMBER}"
        }
    }
}


