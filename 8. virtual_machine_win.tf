# VM — Web Server (Production)

resource "azurerm_windows_virtual_machine" "vm_web" {
  name                  = "vm-web-01"
  resource_group_name   = azurerm_resource_group.prod.name
  location              = azurerm_resource_group.prod.location
  size                  = var.vm_size
  admin_username        = "adminuser"
  admin_password        = "Password@123!"
  network_interface_ids = [azurerm_network_interface.nic_web.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-datacenter-gensecond"
    version   = "latest"
  }
}

# VM — App Server (Production)

resource "azurerm_windows_virtual_machine" "vm_app" {
  name                  = "vm-app-01"
  resource_group_name   = azurerm_resource_group.prod.name
  location              = azurerm_resource_group.prod.location
  size                  = var.vm_size
  admin_username        = "adminuser"
  admin_password        = "Password@123!"
  network_interface_ids = [azurerm_network_interface.nic_app.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-datacenter-gensecond"
    version   = "latest"
  }
}

