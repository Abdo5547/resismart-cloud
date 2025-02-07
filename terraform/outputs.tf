output "frontend_deployment_name" {
  value = kubernetes_deployment.frontend.metadata[0].name
}
