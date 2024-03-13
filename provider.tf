terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.94.0"
    }
  }
}

provider "azurerm" {
    subscription_id = var.subscription_id
    skip_provider_registration = true
  features {
  }
}