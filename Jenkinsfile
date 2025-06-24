pipeline {
    agent any

    environment {
        DEPLOY_DIR = "${WORKSPACE}/deploy-repo"
    }

    stages {
        stage('Build') {
            steps {
                dir('Amazon') {
                    sh 'mvn clean verify'  // This runs tests and generates surefire-reports
                }
            }
        }

        stage('Deploy') {
            steps {
                dir('Amazon') {
                    sh "mvn deploy -DaltDeploymentRepository=local::default::file=${DEPLOY_DIR}"
                }
            }
        }
    }

    post {
        success {
            echo "✅ Build and Deploy succeeded!"
        }
        failure {
            echo "❌ Pipeline failed. Please check the console output."
        }
        always {
            echo "📦 Build and deploy completed - ${currentBuild.currentResult}"

            archiveArtifacts artifacts: 'Amazon/target/*.jar,Amazon/target/*.war,deploy-repo/**/*', allowEmptyArchive: true

            // Gracefully handle missing test reports
            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                junit
