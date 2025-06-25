pipeline {
    agent any
    environment {
        // Use PATH+EXTRA to append to PATH properly
       bin:/usr/games:/usr/local/games:/snap/bin
    }
    stages {

        stage('pull') {
            steps {
                git branch: 'main', url: 'https://github.com/PraveenKuber/Amazon-Jenkins.git'
            }
        }
        stage('compile test') {
            steps {
                sh 'mvn compile'
            }
        }

        stage('build project') {
            steps {
                 sh 'mvn clean install'
            }
        }

        
    }

  post{

  success{
     echo 'Build success'
  }
    
  failure{
       echo 'Failure in the build'
   }

  }


}
