
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
        withCredentials([
            usernamePassword(
                credentialsId: 'docker-hub-connector',
                usernameVariable: 'DOCKER_HUB_USERNAME',
                passwordVariable: 'DOCKER_HUB_PASSWORD'
            )
        ]) {
            sh """
                echo "$DOCKER_HUB_PASSWORD" | docker login -u "$DOCKER_HUB_USERNAME" --password-stdin
                docker push ${frontendImage}
            """
        }
    }
}

        // Étape 6 : Déployer sur Kubernetes
stage('Deploy to Kubernetes') {
    steps {
        withCredentials([file(credentialsId: 'k8s-config', variable: 'KUBECONFIG')]) {
            sh """
                # Mise à jour dynamique de l'image
                sed -i "s|abdo8558/resismart:frontend.*|${frontendImage}|g" k8s/frontend/frontend.yaml
                
                # Application avec vérification
                kubectl create namespace resismart-prod
                kubectl apply -f k8s/frontend/frontend.yaml --namespace=resismart-prod
                kubectl rollout status deployment/frontend -n resismart-prod --timeout=2m
            """
        }
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
