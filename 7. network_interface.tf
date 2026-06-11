# ════════════════════════════════
# NIC — Web VM
# Connected to web public subnet
# ════════════════════════════════
resource "azurerm_network_interface" "nic_web" {
  name                = "nic-web-01"
  location            = azurerm_resource_group.prod.location
  resource_group_name = azurerm_resource_group.prod.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web_pub.id
    private_ip_address_allocation = "Dynamic"
  }
}

# ════════════════════════════════
# NIC — App VM
# Connected to app private subnet
# ════════════════════════════════
resource "azurerm_network_interface" "nic_app" {
  name                = "nic-app-01"
  location            = azurerm_resource_group.prod.location
  resource_group_name = azurerm_resource_group.prod.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.app_prvt.id
    private_ip_address_allocation = "Dynamic"
  }
}

# ════════════════════════════════
# NIC — Dev VM
# Connected to dev public subnet
# ════════════════════════════════
resource "azurerm_network_interface" "nic_dev" {
  name                = "nic-dev-01"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.dev_pub.id
    private_ip_address_allocation = "Dynamic"
  }
}
