pipeline {
    agent any

    environment {
        DEPLOY_DIR = "${WORKSPACE}/deploy-repo"
    }

    stages {
        stage('Build') {
            steps {
                dir('Amazon') {
                    sh 'mvn clean verify'
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

            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                junit 'Amazon/target/surefire-reports/*.xml'
            }
        }
    }
}  // ✅ this is the final closing brace that was missing

