# NSG for Web Public Subnet
resource "azurerm_network_security_group" "nsg_web_pub" {
  name                = "nsg-web-public"
  location            = azurerm_resource_group.net.location
  resource_group_name = azurerm_resource_group.net.name

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTPS"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-RDP"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# NSG for App Private Subnet
resource "azurerm_network_security_group" "nsg_app_prvt" {
  name                = "nsg-app-private"
  location            = azurerm_resource_group.net.location
  resource_group_name = azurerm_resource_group.net.name

  security_rule {
    name                       = "Allow-From-Web"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.0.1.0/24"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny-Internet"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}

# NSG for DB Private Subnet
resource "azurerm_network_security_group" "nsg_db_prvt" {
  name                = "nsg-db-private"
  location            = azurerm_resource_group.net.location
  resource_group_name = azurerm_resource_group.net.name

  security_rule {
    name                       = "Allow-From-App"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "10.0.2.0/24"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny-All"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# NSG for Dev Subnet
resource "azurerm_network_security_group" "nsg_dev_pub" {
  name                = "nsg-dev-public"
  location            = azurerm_resource_group.net.location
  resource_group_name = azurerm_resource_group.net.name

  security_rule {
    name                       = "Allow-RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# NSG Associations
resource "azurerm_subnet_network_security_group_association" "nsg_web_pub_assoc" {
  subnet_id                 = azurerm_subnet.web_pub.id
  network_security_group_id = azurerm_network_security_group.nsg_web_pub.id
}

resource "azurerm_subnet_network_security_group_association" "nsg_app_prvt_assoc" {
  subnet_id                 = azurerm_subnet.app_prvt.id
  network_security_group_id = azurerm_network_security_group.nsg_app_prvt.id
}

resource "azurerm_subnet_network_security_group_association" "nsg_db_prvt_assoc" {
  subnet_id                 = azurerm_subnet.db_prvt.id
  network_security_group_id = azurerm_network_security_group.nsg_db_prvt.id
}

resource "azurerm_subnet_network_security_group_association" "nsg_dev_pub_assoc" {
  subnet_id                 = azurerm_subnet.dev_pub.id
  network_security_group_id = azurerm_network_security_group.nsg_dev_pub.id
}