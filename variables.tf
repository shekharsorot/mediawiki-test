variable "location"{
  type = string
  description = "(Required) Location of the resource"
}

variable "mysql_resource_group_name"{
  type = string
  description = "(Required) Resource group where to place the Azure DB for MySQL"
}

variable "aks_resource_group_name"{
  type = string
  description = "(Required) Resource group where to place the AKS cluster"
}

variable "mysql_instance_name"{
  type = string
  description = "(Required) Name of the Azure DB for MySQL instance"
}

variable "mysql_db_name"{
  type = string
  description = "(Required) Name of the DB to create for MediaWiki application"
  default = "my_wiki"
}

variable "mysql_virtual_subnet_id"{
  type = string
  description = "(Required) Resource ID of the subnet to place the Azure DB for MySQL. Subnet must have 'Microsoft.DBforMySQL/flexibleServers' delegation to allow action 'Microsoft.Network/virtualNetworks/subnets/join/action'"
}

variable "mysql_private_dns_zone_id"{
  type = string 
  description = "(Required) Value of the private dns zone id for the Azure DB for MySQL instance. This is used to create the private dns record for the Azure DB for MySQL instance. Must be linked to the virtual network"
  default = "/subscriptions/26e8c025-7bdb-4d7c-960f-e8187ec7495a/resourceGroups/sap-network-rg/providers/Microsoft.Network/privateDnsZones/contoso.com"
}

variable "aks_virtual_subnet_id"{
  type = string
  description = "(Required) Resource ID of the subnet where to place the CNI interfaces of AKS nodes"
  default = "/subscriptions/26e8c025-7bdb-4d7c-960f-e8187ec7495a/resourceGroups/sap-network-rg/providers/Microsoft.Network/virtualNetworks/VNET-NEU-Conn/subnets/application"
}

variable "aks_name"{
  type = string 
  description = "(Required) Name of the AKS cluster to create in AKS_Resource_Group_Name"
  default = "aks_mediawiki_test"
}

variable "aks_cluster_dns_prefix"{
  type = string
  description = "(Required) DNS prefix for the AKS cluster. Will be used to create the FQDN for the AKS cluster"
  default = "aks-mediawiki-test"
}


variable "aks_node_count"{
  type = number
  description = "(Optional) Number of initial nodes to provision in the AKS cluster. Is ignored later on when autoscaling is enabled"
  default = 3
}


variable "storage_account"{
  type = string 
  description = "(Required) Name of the storage account to use for the Media Wiki config file. Will be created in the AKS resource group"
  default = "aksmediawikistor01"
}

variable "file_share_names"{
  type = list(string)
  description = "(Optional) Name of the file share to create for the Media Wiki config file. Will be created in the storage account"
  default = ["images", "wikiconfig"]
}

variable "aks_keyvault_name"{
  type = string
  description = "(Required) Keyvault to store passwords, secrets, keys and misc data for AKS and MySQL"
}




