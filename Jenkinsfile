pipeline {
    agent any
PATH="/opt/gradle/latest/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
    stages {
        stage('clone project'){
            step{
                git branch:'deploy-stage',url:'https://github.com/skbasha-devops/Amazon'
            }
        }
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




