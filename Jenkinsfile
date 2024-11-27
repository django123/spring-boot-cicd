def executeCommand(cmd) {
    if (isUnix()) {
        sh cmd
    } else {
        bat cmd
    }
}
pipeline {
    agent any
    stages {
        stage('Verify Branch') {
            steps {
                 script {
                  executeCommand('echo GIT_BRANCH')
                 }

            }
        }
        stage('Docker Build') {
            steps {
              script{
               executeCommand('docker build -t spring-boot-docker .')
              }
            }
        }

    }
}