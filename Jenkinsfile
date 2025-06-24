pipeline {
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
                    echo "Checking build tools..."
                    dir('Amazon') {
                        if (fileExists('pom.xml')) {
                            echo "Maven project detected"
                            sh 'mvn clean package -DskipTests'
                        } else {
                            error "No recognized build configuration found in Amazon/"
                        }
                    }
                }
            }
        }

        stage('Test') {
            steps {
                dir('Amazon') {
                    echo "Running tests..."
                    sh 'mvn test'
                }
            }
        }

        stage('Deploy to Staging') {
            steps {
                dir('Amazon') {
                    echo "Deploying to staging environment..."
                    // Example: copy WAR to test server
                    sh '''
                    scp Amazon-Web/target/Amazon.war ec2-user@192.168.1.100:/opt/tomcat/webapps/
                    '''
                }
            }
        }

        stage('Deploy to Production') {
            steps {
                input message: "Promote to production?"
                dir('Amazon') {
                    echo "Deploying to production..."
                    // Example production deployment
                    sh '''
                    scp Amazon-Web/target/Amazon.war prod-user@192.168.1.200:/opt/tomcat/webapps/
                    '''
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline finished - ${currentBuild.result}"
            cleanWs()
        }
        success {
            echo "✅ Deployment successful"
        }
        failure {
            echo "❌ Deployment failed - please check console output"
        }
    }
}


