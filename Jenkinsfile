
pipeline {
    agent any

    environment {
        frontendImage = "abdo8558/resismart:frontend-${env.BRANCH_NAME}"  // Nom de l'image frontend basé sur la branche
    }

    stages {
        // Étape 1 : Récupérer le code depuis GitHub
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Abdo5547/resismart-cloud.git'
            }
        }

       

    //     Étape 3 : Installer les dépendances et Build du frontend React
        stage('Build Frontend') {
            steps {
                dir('frontend') {  // Se déplacer dans le dossier frontend
                   sh 'npm install' 
            //        sh 'npm run build'    // Reconstruit node_modules
                }
            }
        }

        // Étape 4 : Construire les images Docker
        stage('Build Docker Images') {
            steps {
                sh "docker build -t ${frontendImage} -f frontend/Dockerfile frontend/"
            }
        }

        // Étape 5 : Push to Docker Hub
        stage('Push to Docker Hub') {
            steps {
                // Utilisation des identifiants Docker
                withCredentials([usernamePassword(credentialsId: 'docker-hub-connector', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                    sh "docker push ${backendImage}"
                    sh "docker push ${frontendImage}"
                }
            }
        }

        // Étape 6 : Déployer sur Kubernetes
        stage('Deploy to Kubernetes') {
            steps {
              
                sh 'kubectl apply -f frontend/frontend.yaml'
            }
        }
    }

    // Actions post-build (optionnel)
    post {
        success {
            echo '✅ Déploiement réussi!'
        }
        failure {
            echo '❌ Déploiement échoué!'
        }
    }
}
