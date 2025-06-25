pipeline {
    agent any
    environment {
        PATH = "${env.PATH}:/usr/games:/usr/local/games:/snap/bin"
    }
    stages {
        stage('Test') {
            steps {
                sh 'echo $PATH'
            }
        }
    }
}
