pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                script {
                    echo 'Attempting to build...'
                    
                    // Check what build files exist
                    def buildFiles = findFiles(glob: '*')
                    echo "Found files: ${buildFiles.collect{it.name}}"
                    
                    // Try different build methods
                    try {
                        if (fileExists('Makefile')) {
                            sh 'make --version && make'
                        } else if (fileExists('pom.xml')) {
                            sh 'mvn --version && mvn clean install'
                        } else if (fileExists('build.gradle')) {
                            sh 'gradle --version && gradle build'
                        } else {
                            error('No recognized build files found (Makefile, pom.xml, build.gradle)')
                        }
                    } catch (Exception e) {
                        error("Build failed: ${e.getMessage()}\n" +
                              "Please ensure either:\n" +
                              "1. Make is installed and Makefile exists\n" +
                              "2. Maven is installed and pom.xml exists\n" +
                              "3. Gradle is installed and build.gradle exists")
                    }
                }
            }
        }
    }
}

