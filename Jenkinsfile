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
                sh(script: 'docker build -t spring-boot-docker .', returnStdout: true)
            }
        }
        stage('Docker Push') {
            steps {
                sh 'docker push spring-boot-docker'
            }
        }
    }
}