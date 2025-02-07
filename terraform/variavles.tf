variable "cluster_name" {
  description = "Nom du cluster Kubernetes"
  type        = string
  default     = "my-k8s-cluster"
}

variable "region" {
  description = "Région du cluster (si applicable)"
  type        = string
  default     = "local"
}
