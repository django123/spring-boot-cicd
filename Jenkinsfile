def executeCommand(cmd) {
    if (isUnix()) {
        sh cmd
    } else {
        bat cmd
    }
}
pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'spring-boot-docker'
    }
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
               executeCommand('docker build -t ${DOCKER_IMAGE} .')
              }
            }
        }

    }
}