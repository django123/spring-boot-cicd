def executeCommand(cmd) {
    def normalizedCmd = cmd.replaceAll('\\\\', '/')
    
    if (isUnix()) {
        // Détection de macOS
        def isMac = sh(script: 'uname', returnStdout: true).trim() == 'Darwin'
        if (isMac && cmd.startsWith('docker')) {
            // Sur macOS, on utilise le chemin complet vers Docker
            def macDockerCmd = "/Applications/Docker.app/Contents/Resources/bin/${normalizedCmd}"
            sh macDockerCmd
        } else {
            sh normalizedCmd
        }
    } else {
        bat normalizedCmd
    }
}

pipeline {

  agent any

  environment {
    DOCKER_IMAGE_NAME = "spring-boot-docker"
    DOCKER_IMAGE_TAG = "latest"
    DOCKER_REGISTRY = "docker.io"
    DOCKER_REGISTRY_CREDENTIALS = "docker-registry-credentials"

    // Utilisation de timestamps pour les tags d'image
    BUILD_TIMESTAMP = new Date().format("yyyyMMddHHmmss", TimeZone.getTimeZone('UTC'))
    BUILD_NUMBER = "${env.BUILD_NUMBER}"
    BUILD_ID = "${env.BUILD_ID}"
    BUILD_TAG = "${BUILD_NUMBER}-${BUILD_ID}"

    // Variables pour les tests
    TEST_IMAGE_NAME = "spring-boot-docker-test"
    TEST_IMAGE_TAG = "latest"
  }

  stages {
        stage('Verify Branch'){
            steps {
                    script{
                        // Récuperatio, sûre de la branche sur tous les OS
                        def branch = env.BRANCH_NAME ?: env.BRANCH_NAME
                        excuteCommand("echo \"Build branch: ${branch}\"")
                    }
                }

        }

         stage('Check docker version'){
                    steps {
                        script{
                           excuteCommand('docker --version')
                        }
                    }
        }

        stage('Build Docker Image'){
            steps {
                script{
                //Utilisation d'un tag pour eviter les conflits
                    def imageTag = "${DOCKER_IMAGE_NAME}:${BUILD_TAG}"
                    excuteCommand("docker build -t ${imageTag} .")

                 // Tag également comme latest
                    excuteCommand("docker tag ${imageTag} ${DOCKER_IMAGE_NAME}:latest")
                }
            }
        }
  }

  post {
    always {
        script {
            // Nettoyage des resources Docker si nécessaire

            excuteCommand('docker system prune -f')
        }
    }
  }
}