# create the resource groups
resource "azurerm_resource_group" "mysql" {
  name     = var.mysql_resource_group_name
  location = var.location
}


resource "azurerm_resource_group" "aks" {
  name     = var.aks_resource_group_name
  location = var.location
}


# Create a random password for mysql login
resource "random_password" "mysql" {
  length           = 8
  lower            = true
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  numeric          = true
  override_special = "_"
  special          = true
  upper            = true
}

resource "random_string" "username" {
  length           = 10
  special          = true
  override_special = "_"
}

# Create the Azure DB for MySQL instance
resource "azurerm_mysql_flexible_server" "mediawiki"{
  location = azurerm_resource_group.mysql.location
  name = var.mysql_instance_name
  resource_group_name = azurerm_resource_group.mysql.name
  administrator_login = "sqladmin"
  administrator_password = random_password.mysql.result
  backup_retention_days = 7
  delegated_subnet_id = var.mysql_virtual_subnet_id
  geo_redundant_backup_enabled = false
  private_dns_zone_id          = var.mysql_private_dns_zone_id
  sku_name                     = "GP_Standard_D2ads_v5"
  version                      = "8.0.21"
  maintenance_window {
    day_of_week  = 0
    start_hour   = 8
    start_minute = 0
  }
  storage {
    iops    = 360
    size_gb = 20
  }
  lifecycle {
    ignore_changes = [ zone ]
  }
}

# Create the mediawiki database
# Manages the MySQL Flexible Server Database
resource "azurerm_mysql_flexible_database" "mediawiki" {
  charset             = "utf8mb3"
  collation           = "utf8mb3_unicode_ci"
  name                = var.mysql_db_name
  resource_group_name = azurerm_resource_group.mysql.name
  server_name         = azurerm_mysql_flexible_server.mediawiki.name
}

# Configure firewall to allow inbound traffic to MySQL instance
resource "azurerm_mysql_flexible_server_firewall_rule" "mediawiki" {
  name                = "AllowAzureService"
  resource_group_name = azurerm_resource_group.mysql.name
  server_name         = azurerm_mysql_flexible_server.mediawiki.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

#Disable SSL for supporting MediaWiki
resource "azurerm_mysql_flexible_server_configuration" "mediawiki" {
  name                = "require_secure_transport"
  resource_group_name = azurerm_resource_group.mysql.name
  server_name         = azurerm_mysql_flexible_server.mediawiki.name
  value               = "OFF"
}