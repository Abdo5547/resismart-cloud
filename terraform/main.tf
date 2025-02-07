provider "kubernetes" {
  # Pour Minikube, récupère l'URL et le certificat via `minikube kubectl -- get pods`
  host                   = "https://127.0.0.1:8443"
  cluster_ca_certificate = base64decode("YOUR_MINIKUBE_CA_CERTIFICATE")
  # Pour Minikube, tu peux utiliser un token si nécessaire ou la configuration par défaut
  token                  = "YOUR_MINIKUBE_TOKEN"
}

resource "kubernetes_deployment" "frontend" {
  metadata {
    name = "frontend"
    labels = {
      app = "frontend"
    }
  }

  spec {
    replicas = 2
    selector {²
      match_labels = {
        app = "frontend"
      }
    }
    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }
      spec {
        container {
          name  = "frontend"
          image = "abdo8558/resismart:frontend"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "frontend" {
  metadata {
    name = "frontend"
  }
  spec {
    selector = {
      app = "frontend"
    }
    ports {
      port        = 80
      target_port = 80
      node_port   = 30008
    }
    type = "NodePort"
  }
}
