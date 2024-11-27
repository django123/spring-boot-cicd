def excuteCommand(cmd) {
  // Pour les commandes Docker, on normalise les slashes sur Windows
  def normalizedCmd = cmd.replaceAll("\\\\", "/")

  if (isUnix()) {
    sh normalizedCmd
  } else {
  // Sur windows, certaines commandes doivent être adaptées
    if(cmd.startsWith("docker ")) {
      bat normalizedCmd
    } else {
    // Pour les autres, on exécute la commande normalement
      bat "cmd /c ${normalizedCmd}"
    }
  }
}

pipeline {

  agent any

  environment {
    DOCKER_IMAGE_NAME = "spring-boot-docker"
    DOCKER_IMAGE_TAG = "latest"
    DOCKER_REGISTRY = "https://hub.docker.com/"
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

        stage('Docker Push Image'){
            steps {
                script{
                            def dockerUsername = "django91"  // Remplacez par votre nom d'utilisateur Docker Hub
                            def dockerPassword = "django123"  // Remplacez par votre mot de passe Docker Hub ou token
                            def imageTag = "${DOCKER_IMAGE_NAME}:${BUILD_TAG}"
                             excuteCommand(' echo ${dockerPassword} | docker login -u ${dockerUsername} --password-stdin ${registry}')

/*                         withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                           excuteCommand(' echo ${dockerPassword} | docker login -u ${dockerUsername} --password-stdin ${registry}')
                        } */
                        excuteCommand("docker push ${imageTag}")
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