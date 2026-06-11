resource "azurerm_virtual_network" "prod_vnet" {
  name                = var.prod_vnet.name
  address_space       = [var.prod_vnet.address]
  location            = azurerm_resource_group.net.location
  resource_group_name = azurerm_resource_group.net.name
}

resource "azurerm_virtual_network" "dev_vnet" {
  name                = var.dev_vnet.name
  address_space       = [var.dev_vnet.address]
  location            = azurerm_resource_group.net.location
  resource_group_name = azurerm_resource_group.net.name
}
