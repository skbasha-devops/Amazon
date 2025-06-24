pipeline {
    agent any

 stage('Deploy to Staging') {
    steps {
        dir('Amazon') {
            echo 'Deploying to staging environment... (skipped actual deployment)'
            archiveArtifacts artifacts: 'Amazon-Web/target/Amazon.war', fingerprint: true
        }
    }
}

stage('Deploy to Production') {
    when {
        expression { return currentBuild.result == null || currentBuild.result == 'SUCCESS' }
    }
    steps {
        input message: "Promote to Production?"
        dir('Amazon') {
            echo 'Deploying to production... (skipped actual deployment)'
            // You can archive again or just log
            echo 'Production deployment complete (simulated).'
        }
    }
}



