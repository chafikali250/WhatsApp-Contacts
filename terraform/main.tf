terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

variable "client_secret" {
  type      = string
  sensitive = true
}

provider "azurerm" {
  features {}
  subscription_id = "..."
  client_id       = "..."
  client_secret   = var.client_secret
  tenant_id       = "..."
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-whatsapp-contacts"
  location = "northeurope"
}

resource "azurerm_container_app_environment" "env" {
  name                = "cae-whatsapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_container_app" "app" {
  name                         = "ca-whatsapp-api"
  container_app_environment_id = azurerm_container_app_environment.env.id
  resource_group_name          = azurerm_resource_group.rg.name
  revision_mode                = "Single"

  template {
    container {
      name   = "whatsapp-cpp-app"
      image  = "docker.io/chali250/whatsapp-cpp-app:latest"
      cpu    = 0.5
      memory = "1.0Gi"
    }
  }

  ingress {
    external_enabled = true
    target_port      = 8080
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
}

output "api_url" {
  value       = "https://${azurerm_container_app.app.ingress[0].fqdn}"
  description = "URL publique de l'API WhatsApp Contact Management"
}

