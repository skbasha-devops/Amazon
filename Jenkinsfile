parameters {
    choice(name: 'BUILD_TOOL', choices: ['maven', 'make'], description: 'Select build tool')
}
...
steps {
    dir('Amazon') {
        script {
            if (params.BUILD_TOOL == 'maven') {
                sh 'mvn clean package deploy -DskipTests'
            } else {
                sh 'make package && make deploy-staging'
            }
        }
    }
}
