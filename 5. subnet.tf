resource "azurerm_subnet" "web_pub" {
  name                 = var.prod_sub.web_publ.name
  address_prefixes     = [var.prod_sub.web_publ.prefix]
  resource_group_name  = azurerm_resource_group.net.name
  virtual_network_name = azurerm_virtual_network.prod_vnet.name
}

resource "azurerm_subnet" "app_prvt" {
  name                 = var.prod_sub.app_prvt.name
  address_prefixes     = [var.prod_sub.app_prvt.prefix]
  resource_group_name  = azurerm_resource_group.net.name
  virtual_network_name = azurerm_virtual_network.prod_vnet.name
}

resource "azurerm_subnet" "db_prvt" {
  name                 = var.prod_sub.db_prvt.name
  address_prefixes     = [var.prod_sub.db_prvt.prefix]
  resource_group_name  = azurerm_resource_group.net.name
  virtual_network_name = azurerm_virtual_network.prod_vnet.name
}

resource "azurerm_subnet" "dev_pub" {
  name                 = var.dev_sub.dev_publ.name
  address_prefixes     = [var.dev_sub.dev_publ.prefix]
  resource_group_name  = azurerm_resource_group.net.name
  virtual_network_name = azurerm_virtual_network.dev_vnet.name
}

resource "azurerm_subnet" "dev_prvt" {
  name                 = var.dev_sub.dev_prvt.name
  address_prefixes     = [var.dev_sub.dev_prvt.prefix]
  resource_group_name  = azurerm_resource_group.net.name
  virtual_network_name = azurerm_virtual_network.dev_vnet.name
}

resource "azurerm_subnet" "appgw" {
  name                 = var.prod_sub.appgw.name
  resource_group_name  = azurerm_resource_group.net.name
  virtual_network_name = azurerm_virtual_network.prod_vnet.name
  address_prefixes     = [var.prod_sub.appgw.prefix]
}
