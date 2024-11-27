pipeline {
    agent any
    stages {
        stage('Verify Branch') {
            steps {
                  bat "echo %GIT_BRANCH%"
            }
        }
        stage('Docker Build') {
            steps {
                bat 'docker build -t spring-boot-docker .'
            }
        }
        stage('Docker Push') {
            steps {
                bat 'docker push spring-boot-docker'
            }
        }
    }
}