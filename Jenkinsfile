pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                dir('Amazon') {
                    sh 'mvn clean package'
                }
            }
        }
        
        stage('Deploy') {
            steps {
                dir('Amazon') {
                    // Deploy to local filesystem repo if no other repo configured
                    sh 'mvn deploy -DaltDeploymentRepository=local::default::file:${WORKSPACE}/deploy-repo'
                }
            }
        }
    }
    
  post {
    always {
        echo "Build and deploy completed - ${currentBuild.currentResult}"
        archiveArtifacts artifacts: 'Amazon/target/*.jar,Amazon/target/*.war,deploy-repo/**/*', allowEmptyArchive: true
        catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
            junit 'Amazon/target/*-reports/*.xml'
        }
    }
}
