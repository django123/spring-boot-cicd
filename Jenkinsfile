def executeCommand(command){
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
                 executeCommand('echo GIT_BRANCH')
            }
        }
        stage('Docker Build') {
            steps {
               executeCommand('docker build -t spring-boot-docker .')
            }
        }

    }
}