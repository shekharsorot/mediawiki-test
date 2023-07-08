<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | >=1.4.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.46.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >=3.4.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >=0.9.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | >=1.4.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.46.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | >=3.4.3 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azapi_resource.ssh_public_key](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_resource_action.ssh_public_key_gen](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource_action) | resource |
| [azurerm_key_vault.mediawiki](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_secret.aks-private-key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_kubernetes_cluster.mediawiki-k8s](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_mysql_flexible_database.mediawiki](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_database) | resource |
| [azurerm_mysql_flexible_server.mediawiki](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server) | resource |
| [azurerm_mysql_flexible_server_configuration.mediawiki](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server_configuration) | resource |
| [azurerm_mysql_flexible_server_firewall_rule.mediawiki](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server_firewall_rule) | resource |
| [azurerm_resource_group.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.mysql](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.mediawiki](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_share.images](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |
| [azurerm_storage_share.wikiconfig](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |
| [helm_release.mediawiki-bitnami](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [random_password.mysql](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.username](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [tls_private_key.ssh-key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_cluster_dns_prefix"></a> [aks\_cluster\_dns\_prefix](#input\_aks\_cluster\_dns\_prefix) | (Required) DNS prefix for the AKS cluster. Will be used to create the FQDN for the AKS cluster | `string` | `"aks-mediawiki-test"` | no |
| <a name="input_aks_keyvault_name"></a> [aks\_keyvault\_name](#input\_aks\_keyvault\_name) | (Required) Keyvault to store passwords, secrets, keys and misc data for AKS and MySQL | `string` | n/a | yes |
| <a name="input_aks_name"></a> [aks\_name](#input\_aks\_name) | (Required) Name of the AKS cluster to create in AKS\_Resource\_Group\_Name | `string` | `"aks_mediawiki_test"` | no |
| <a name="input_aks_node_count"></a> [aks\_node\_count](#input\_aks\_node\_count) | (Optional) Number of initial nodes to provision in the AKS cluster. Is ignored later on when autoscaling is enabled | `number` | `3` | no |
| <a name="input_aks_resource_group_name"></a> [aks\_resource\_group\_name](#input\_aks\_resource\_group\_name) | (Required) Resource group where to place the AKS cluster | `string` | n/a | yes |
| <a name="input_aks_virtual_subnet_id"></a> [aks\_virtual\_subnet\_id](#input\_aks\_virtual\_subnet\_id) | (Required) Resource ID of the subnet where to place the CNI interfaces of AKS nodes | `string` | `"/subscriptions/26e8c025-7bdb-4d7c-960f-e8187ec7495a/resourceGroups/sap-network-rg/providers/Microsoft.Network/virtualNetworks/VNET-NEU-Conn/subnets/application"` | no |
| <a name="input_file_share_names"></a> [file\_share\_names](#input\_file\_share\_names) | (Optional) Name of the file share to create for the Media Wiki config file. Will be created in the storage account | `list(string)` | <pre>[<br>  "images",<br>  "wikiconfig"<br>]</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Location of the resource | `string` | n/a | yes |
| <a name="input_mysql_db_name"></a> [mysql\_db\_name](#input\_mysql\_db\_name) | (Required) Name of the DB to create for MediaWiki application | `string` | `"my_wiki"` | no |
| <a name="input_mysql_instance_name"></a> [mysql\_instance\_name](#input\_mysql\_instance\_name) | (Required) Name of the Azure DB for MySQL instance | `string` | n/a | yes |
| <a name="input_mysql_private_dns_zone_id"></a> [mysql\_private\_dns\_zone\_id](#input\_mysql\_private\_dns\_zone\_id) | (Required) Value of the private dns zone id for the Azure DB for MySQL instance. This is used to create the private dns record for the Azure DB for MySQL instance. Must be linked to the virtual network | `string` | `"/subscriptions/26e8c025-7bdb-4d7c-960f-e8187ec7495a/resourceGroups/sap-network-rg/providers/Microsoft.Network/privateDnsZones/contoso.com"` | no |
| <a name="input_mysql_resource_group_name"></a> [mysql\_resource\_group\_name](#input\_mysql\_resource\_group\_name) | (Required) Resource group where to place the Azure DB for MySQL | `string` | n/a | yes |
| <a name="input_mysql_virtual_subnet_id"></a> [mysql\_virtual\_subnet\_id](#input\_mysql\_virtual\_subnet\_id) | (Required) Resource ID of the subnet to place the Azure DB for MySQL. Subnet must have 'Microsoft.DBforMySQL/flexibleServers' delegation to allow action 'Microsoft.Network/virtualNetworks/subnets/join/action' | `string` | n/a | yes |
| <a name="input_storage_account"></a> [storage\_account](#input\_storage\_account) | (Required) Name of the storage account to use for the Media Wiki config file. Will be created in the AKS resource group | `string` | `"aksmediawikistor01"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_data"></a> [key\_data](#output\_key\_data) | This is a bad idea. Keys should go into key vault |
<!-- END_TF_DOCS -->