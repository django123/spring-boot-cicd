pipeline {
    agent any
    stages {
        stage('Verify Branch') {
            steps {
                echo  "$GIT_BRANCH"
            }
        }
        stage('Docker Build') {
            steps {
              script {
                sh 'docker build -t spring-boot-docker .'
              }
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}