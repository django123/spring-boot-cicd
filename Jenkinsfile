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

        stage('Docker Push Image'){
            steps {
                script{
//                     // On utilise le registry défini dans l'environnement
//                     def registry = "${DOCKER_REGISTRY}"
//                     def registryCredentials = "${DOCKER_REGISTRY_CREDENTIALS}"
//
//                     // On utilise le tag défini dans l'environnement
//                     def imageTag = "${DOCKER_IMAGE_NAME}:${BUILD_TAG}"
//
//                     // On utilise le nom défini dans l'environnement
//                     def imageName = "${DOCKER_IMAGE_NAME}"



                   /*  withCredentials([usernamePassword(credentialsId: registryCredentials, passwordVariable: 'django123', usernameVariable: 'django91')]) {
                        // On push l'image sur le registry
                        excuteCommand("docker login -u ${username} -p ${password} ${registry}")
                        excuteCommand("docker push ${imageTag}")
                    } */

                     withCredentials([string(credentialsId: 'dockerhub', variable: 'dockerhub')]) {
                                     excuteCommand('docker login -u django91 -p ${dockerhub}')
                                     excuteCommand('docker login -u django91 -p ${dockerhub}')
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