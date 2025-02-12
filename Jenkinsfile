
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
                usernameVariable: 'DOCKER_HUB_USERNAME',  // Assurez-vous que ces noms
                passwordVariable: 'DOCKER_HUB_PASSWORD'   // correspondent aux variables utilisées
            )
        ]) {
            sh '''
                echo "$DOCKER_HUB_PASSWORD" | docker login -u "$DOCKER_HUB_USERNAME" --password-stdin
                docker push abdo8558/resismart:frontend
            '''
        }
    }
}

        // Étape 6 : Déployer sur Kubernetes
        stage('Deploy to Kubernetes') {
    steps {
        withCredentials([file(credentialsId: 'k8s-config', variable: 'KUBECONFIG')]) {
            sh '''
                # Exemple : Mise à jour du tag de l'image (ajustez selon vos besoins)
                sed -i "s|abdo8558/resismart:frontend.*|abdo8558/resismart:frontend:latest|g" k8s/frontend/frontend.yaml
                
                # Appliquer la configuration Kubernetes
                kubectl apply -f k8s/frontend/frontend.yaml
            '''
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
