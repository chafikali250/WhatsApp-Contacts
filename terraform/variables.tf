variable "resource_group_name" {
  type        = string
  description = "Nom du groupe de ressources Azure"
  default     = "rg-whatsapp-contacts"
}

variable "location" {
  type        = string
  description = "Région Azure pour le déploiement"
  default     = "westeurope"
}

variable "container_image" {
  type        = string
  description = "Image Docker sur Docker Hub"
  default     = "docker.io/chali250/whatsapp-cpp-app:latest"
}
