def executeCommand(cmd) {
    if (isUnix()) {
           sh cmd // Exécution pour Linux/macOS
       } else {
           bat cmd.replace("${env.DOCKER_PASSWORD}", "%DOCKER_PASSWORD%")
                      .replace("${env.DOCKER_USERNAME}", "%DOCKER_USERNAME%") // Exécution pour Windows
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
               executeCommand('docker build -t spring-boot-docker .')
              }
            }
        }

    }
}