pipeline {
    agent any

    environment {
        WAR_FILE = 'Amazon/Amazon-Web/target/Amazon.war'
        REMOTE_USER = 'ec2-user'                    // your server user
        REMOTE_HOST = '192.168.1.100'               // your server IP
        REMOTE_PATH = '/opt/tomcat/webapps/'        // Tomcat webapps directory
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                echo "✅ Checked out code from ${env.GIT_URL}"
            }
        }

        stage('Build') {
            steps {
                script {
                    if (fileExists('pom.xml')) {
                        echo "Building Maven project..."
                        sh 'mvn clean package -DskipTests'
                    } else {
                        error "pom.xml not found. Not a Maven project."
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    if (fileExists("${WAR_FILE}")) {
                        echo "Deploying WAR file to Tomcat..."
                        sh """
                            scp ${WAR_FILE} ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}
                        """
                    } else {
                        error "WAR file not found: ${WAR_FILE}"
                    }
                }
            }
        }
    }

    post {
        success {
            echo "🚀 Deployment complete: ${WAR_FILE} -> ${REMOTE_HOST}:${REMOTE_PATH}"
        }
        failure {
            echo "❌ Deployment failed. Check logs."
        }
    }
}


