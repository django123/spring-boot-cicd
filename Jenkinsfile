pipeline {
    agent any
    stages {
        stage('Verify Branch') {
            steps {
                 script {
                   if(isUnix()){
                     sh 'echo $GIT_BRANCH'
                   }
                   else{
                      bat "echo %GIT_BRANCH%"
                   }
                 }

            }
        }
        stage('Docker Build') {
            steps {
              script{
                if(isUnix()){
                  sh 'docker build -t spring-boot-docker .'
                }
                else{
                  bat "docker build -t spring-boot-docker ."
                }
              }
            }
        }

    }
}