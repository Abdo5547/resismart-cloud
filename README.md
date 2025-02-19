# Projet DevOps avec Git, Docker, Kubernetes, Jenkins, Terraform et Ansible

Bienvenue dans le projet DevOps qui intègre plusieurs outils puissants pour automatiser la gestion des applications et de l'infrastructure. Ce projet couvre l'utilisation de **Git**, **Docker**, **Kubernetes**, **Jenkins**, **Terraform**, et **Ansible** pour implémenter un pipeline CI/CD complet.

---

## 🚀 Objectif du Projet

Ce projet a pour objectif de mettre en place une chaîne d'intégration et de déploiement continue (CI/CD) automatisée avec des outils DevOps modernes. Voici les outils que nous allons utiliser :

- **Git** : Gestion de versions pour le code source.
- **Docker** : Conteneurisation des applications.
- **Kubernetes** : Orchestration des conteneurs.
- **Jenkins** : Automatisation du pipeline CI/CD.
- **Terraform** : Infrastructure as code pour gérer l'infrastructure.
- **Ansible** : Automatisation de la configuration des serveurs.

---

## 🛠️ Prérequis

Avant de commencer, assurez-vous que vous avez installé les outils suivants :

- **[Git](https://git-scm.com/)** : Pour gérer le code source.
- **[Docker](https://www.docker.com/)** : Pour créer et gérer des conteneurs.
- **[Kubernetes](https://kubernetes.io/)** : Pour orchestrer vos conteneurs Docker.
- **[Jenkins](https://www.jenkins.io/)** : Pour automatiser l'intégration et le déploiement.
- **[Terraform](https://www.terraform.io/)** : Pour automatiser la gestion de l'infrastructure.
- **[Ansible](https://www.ansible.com/)** : Pour automatiser la configuration des serveurs.

---

## 📋 Étapes de Configuration

### 1. **Installation des outils nécessaires**

Installez les outils ci-dessus sur votre machine ou sur vos serveurs. Vous pouvez trouver des guides d'installation pour chaque outil dans les liens fournis.

### 2. **Installation des plugins Jenkins**

Dans Jenkins, vous devez installer les plugins suivants pour intégrer les différents outils :

- **Docker Plugin** : Pour intégrer Docker avec Jenkins.
- **Git Plugin** : Pour gérer les dépôts Git.
- **Kubernetes Plugin** : Pour interagir avec le cluster Kubernetes.
- **NodeJS Plugin** : Pour gérer l'environnement Node.js dans Jenkins.

### 3. **Configuration des identifiants et secrets**

Ensuite, vous devez configurer les identifiants et secrets pour les outils suivants :

- **Docker Hub Credentials** : Ajoutez vos identifiants Docker Hub dans Jenkins.
- **GitHub Credentials** : Ajoutez vos identifiants GitHub pour cloner des dépôts.
- **Kubernetes Credentials** : Créez un fichier de configuration pour Kubernetes et ajoutez-le dans Jenkins comme un fichier secret contenant le chemin d'accès.

### 4. **Lancement du Pipeline CI/CD**

Une fois les outils installés et les identifiants configurés, vous pouvez lancer votre pipeline Jenkins. Voici les étapes générales du pipeline :

1. **Clonage du dépôt Git** : Jenkins va cloner le code source depuis GitHub.
2. **Création de l'image Docker** : L'application sera conteneurisée avec Docker.
3. **Déploiement Kubernetes** : Le conteneur sera déployé sur un cluster Kubernetes.

### 5. **Gestion de l'infrastructure avec Terraform**

Pour gérer l'infrastructure, accédez au dossier Terraform, et appliquez les commandes suivantes :

1. **Modifiez le fichier `main.tf`** : Ajoutez l'ID de session et toute autre information nécessaire.
2. **Exécutez les commandes Terraform** :
   ```bash
   terraform init    # Initialisation de Terraform
   terraform plan    # Création du plan d'exécution
   terraform apply   # Application des modifications à l'infrastructure
