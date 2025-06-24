pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
                echo "Code checked out from ${env.GIT_URL}"
            }
        }
        
        stage('Discover Projects') {
            steps {
                script {
                    // List all projects in the workspace
                    def projects = findFiles(glob: '*')
                    echo "Found projects: ${projects.collect{it.name}}"
                    
                    // Try to find projects with test configurations
                    def testableProjects = projects.findAll { project ->
                        fileExists("${project.name}/pom.xml") || 
                        fileExists("${project.name}/package.json") ||
                        fileExists("${project.name}/build.gradle")
                    }
                    
                    if (testableProjects.isEmpty()) {
                        error("No projects with test configurations found")
                    }
                    
                    // Store the list of testable projects
                    env.TESTABLE_PROJECTS = testableProjects.collect{it.name}.join(',')
                }
            }
        }
        
        stage('Run Tests') {
            steps {
                script {
                    def failedTests = []
                    
                    env.TESTABLE_PROJECTS.split(',').each { project ->
                        try {
                            dir(project) {
                                echo "Testing project: ${project}"
                                
                                if (fileExists('pom.xml')) {
                                    sh 'mvn test'
                                } else if (fileExists('package.json')) {
                                    sh 'npm install && npm test'
                                } else if (fileExists('build.gradle')) {
                                    sh 'gradle test'
                                }
                            }
                        } catch (Exception e) {
                            failedTests << project
                            echo "Tests failed for ${project}: ${e.getMessage()}"
                        }
                    }
                    
                    if (!failedTests.isEmpty()) {
                        error("Tests failed for projects: ${failedTests.join(',')}")
                    }
                }
            }
        }
    }
    
    post {
        always {
            // Collect test results from all projects
            junit '**/target/surefire-reports/*.xml' // Maven
            junit '**/build/test-results/**/*.xml'   // Gradle
            junit '**/test-results/**/*.xml'        // Other
            
            // Archive test reports if they exist
            archiveArtifacts artifacts: '**/reports/**/*, **/target/surefire-reports/*.xml, **/build/test-results/**/*.xml', allowEmptyArchive: true
            
            // Clean up workspace
            cleanWs()
        }
    }
}
