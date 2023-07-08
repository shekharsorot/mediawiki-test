# Create a file share for storing mediawiki configuration files

resource "azurerm_storage_account" "mediawiki"{
  name = var.storage_account
  resource_group_name = azurerm_resource_group.aks.name
  location = azurerm_resource_group.aks.location
  account_tier = "Standard"
  account_kind = "StorageV2"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public  = false
  enable_https_traffic_only  = true
}

# Create file shares for mediawiki
resource "azurerm_storage_share" "wikiconfig" {
  name = "wikiconfig"
  storage_account_name = azurerm_storage_account.mediawiki.name
  quota = 50
}

resource "azurerm_storage_share" "images" {
  name = "images"
  storage_account_name = azurerm_storage_account.mediawiki.name
  quota = 50
}

