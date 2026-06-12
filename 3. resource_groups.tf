resource "azurerm_resource_group" "net" {
  name     = var.resource_groups.net
  location = var.location

}

resource "azurerm_resource_group" "prod" {
  name     = var.resource_groups.prod
  location = var.location

}

resource "azurerm_resource_group" "dev" {
  name     = var.resource_groups.dev
  location = var.location

}
