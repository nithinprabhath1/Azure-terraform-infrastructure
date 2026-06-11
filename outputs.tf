# RESOURCE GROUP OUTPUTS

output "rg_networking_name" {
  value = azurerm_resource_group.net.name
}

output "rg_production_name" {
  value = azurerm_resource_group.prod.name
}

output "rg_dev_name" {
  value = azurerm_resource_group.dev.name
}

# VNET OUTPUTS

output "prod_vnet_id" {
  value = azurerm_virtual_network.prod_vnet.id
}

output "dev_vnet_id" {
  value = azurerm_virtual_network.dev_vnet.id
}

# SUBNET OUTPUTS

output "subnet_web_pub_id" {
  value = azurerm_subnet.web_pub.id
}

output "subnet_app_prvt_id" {
  value = azurerm_subnet.app_prvt.id
}

output "subnet_db_prvt_id" {
  value = azurerm_subnet.db_prvt.id
}

output "subnet_appgw_id" {
  value = azurerm_subnet.appgw.id
}

# VM PRIVATE IP OUTPUTS

output "vm_web_private_ip" {
  value = azurerm_network_interface.nic_web.private_ip_address
}

output "vm_app_private_ip" {
  value = azurerm_network_interface.nic_app.private_ip_address
}

output "vm_dev_private_ip" {
  value = azurerm_network_interface.nic_dev.private_ip_address
}

# APP GATEWAY OUTPUTS

output "appgw_public_ip" {
  value = azurerm_public_ip.appgw_pip.ip_address
}
# ════════════════════════════════
# KEY VAULT & STORAGE OUTPUTS

output "key_vault_name" {
  value = azurerm_key_vault.kv.name
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}