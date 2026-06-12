# ════════════════════════════════
# KEY VAULT
# Stores secrets securely
# ════════════════════════════════

# Get current user's object ID
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                = "kv-azureti-prod"
  location            = azurerm_resource_group.prod.location
  resource_group_name = azurerm_resource_group.prod.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Purge"
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = "9a4253ae-2dd1-4fc4-bce5-8f71b1fd5446"

    secret_permissions = [
      "Get",
      "List"
    ]
  }
}

# Store VM password as secret
resource "azurerm_key_vault_secret" "vm_password" {
  name         = "vm-admin-password"
  value        = "Password@123!"
  key_vault_id = azurerm_key_vault.kv.id
}
