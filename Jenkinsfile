pipeline {
    agent any
    
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
                echo "Checked out code successfully"
            }
        }
        
        stage('Run Tests') {
            steps {
                script {
                    // List of project directories to check
                    def projects = ['Amazon', 'SKY', 'SpringCore', 'SpringDemo', 'SpringNew', 'test', 'Test']
                    def tested = false
                    
                    projects.each { project ->
                        dir(project) {
                            if (fileExists('pom.xml')) {
                                echo "Testing Maven project: ${project}"
                                sh 'mvn test'
                                tested = true
                            } else if (fileExists('package.json')) {
                                echo "Testing Node.js project: ${project}"
                                sh 'npm install && npm test'
                                tested = true
                            }
                        }
                    }
                    
                    if (!tested) {
                        error "No testable projects found in: ${projects}"
                    }
                }
            }
        }
    }
    
    post {
        always {
            // Collect test results from all projects
            junit allowEmptyResults: true, testResults: '**/target/surefire-reports/*.xml,**/test-results/*.xml'
            echo "Pipeline completed - ${currentBuild.currentResult}"
        }
    }
}
