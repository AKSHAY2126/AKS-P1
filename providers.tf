terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.3.0"
    }
  }
}

provider "azurerm" {
 features {}
 subscription_id = "aeda3064-5734-4759-bc5b-fe8e55b99c9e"
}