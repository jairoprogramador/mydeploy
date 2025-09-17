terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.41.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.5.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.4"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {}

provider "null" {}