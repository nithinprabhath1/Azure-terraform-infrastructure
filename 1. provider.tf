terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.74.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-production"
    storage_account_name = "stazterrainfraproj1"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = "8f683f3b-6556-4979-a8b8-e0505f9a1303"
}
