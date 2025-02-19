# Projet DevOps avec Git, Docker, Kubernetes, Jenkins, Terraform et Ansible

Bienvenue dans le projet DevOps qui intègre plusieurs outils puissants pour automatiser la gestion des applications et de l'infrastructure. Ce projet couvre l'utilisation de **Git**, **Docker**, **Kubernetes**, **Jenkins**, **Terraform**, et **Ansible** pour implémenter un pipeline CI/CD complet.

---

## 🚀 Objectif du Projet

Ce projet a pour objectif de mettre en place une chaîne d'intégration et de déploiement continue (CI/CD) automatisée avec des outils DevOps modernes.

---

## 🛠️ Prérequis

Avant de commencer, assurez-vous que vous avez installé les outils suivants :

- **[Git](https://git-scm.com/)**
- **[Docker](https://www.docker.com/)**
- **[Kubernetes](https://kubernetes.io/)**
- **[Jenkins](https://www.jenkins.io/)**
- **[Terraform](https://www.terraform.io/)**
- **[Ansible](https://www.ansible.com/)**

---

## 📋 Étapes de Configuration

### 1. **Installation des outils nécessaires**

Installez les outils mentionnés ci-dessus.

### 2. **Installation des plugins Jenkins**

Dans Jenkins, installez les plugins suivants :

- Docker Plugin
- Git Plugin
- Kubernetes Plugin
- NodeJS Plugin

### 3. **Configuration des identifiants et secrets**

Ajoutez vos identifiants Docker Hub, GitHub et Kubernetes dans Jenkins.

### 4. **Lancement du Pipeline CI/CD**

Le pipeline se compose des étapes suivantes :

1. Clonage du dépôt Git
2. Création de l'image Docker
3. Déploiement Kubernetes

### 5. **Infrastructure as Code avec Terraform**

Exécutez les commandes suivantes :

```bash
terraform init    # Initialisation de Terraform
terraform plan    # Création du plan d'exécution
terraform apply   # Application des modifications à l'infrastructure

### 6. **Configuration Ansible**

1. Création d'un vault Ansible pour stocker les informations sensibles :

```bash
ansible-vault create credentials.yml
```

2. Ajout des informations sensibles dans `credentials.yml` (sans afficher les données personnelles) :

```yaml
# credentials.yml
  # Docker Hub
  dockerhub_username: "votre_username"
  dockerhub_password: "votre_mot_de_passe"

  # GitHub
  github_username: "votre_username"
  github_password: "votre_token"

  # Kubernetes Secret (kubeconfig)
  kubeconfig:
    path: /home/user/kubeconfig

# Jenkins Admin Credentials (optionnel)
  jenkins_admin_user: "admin"
  jenkins_admin_password: "votre_mot_de_passe"
```

3. Modification du fichier `inventory.ini` pour ajouter les identifiants des machines virtuelles.

4. Exécution de la commande suivante pour éditer le vault en cas de besoin :

```bash
ansible-vault edit credentials.yml
```

