# Create a keyvault for storing secrets

resource "azurerm_key_vault" "mediawiki"{
  name = var.aks_keyvault_name
  resource_group_name = azurerm_resource_group.aks.name
  location = azurerm_resource_group.aks.location
  sku_name = "standard"
  tenant_id = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled = false

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get","Backup","Restore","Set","Purge","Recover","Delete","List"
    ]

    storage_permissions = [
      "Get",
    ]
  }

}

