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
                echo 'Building..'
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