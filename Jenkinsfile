pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                dir('Amazon') {
                    echo 'Building project...'
                    sh 'mvn clean package -DskipTests'
                }
            }
        }

        stage('Test') {
            steps {
                dir('Amazon') {
                    echo 'Running tests...'
                    sh 'mvn test'
                }
            }
        }

        stage('Deploy to Staging') {
            steps {
                dir('Amazon') {
                    echo 'Simulating deploy to staging...'
                    archiveArtifacts artifacts: 'Amazon-Web/target/Amazon.war', fingerprint: true
                }
            }
        }

        stage('Deploy to Production') {
            steps {
                input message: "Promote to Production?"
                dir('Amazon') {
                    echo 'Simulating deploy to production...'
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning workspace...'
            cleanWs()
        }
    }
}




