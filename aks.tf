# # Create the AKS instance for hosting mediawiki frontend

resource "tls_private_key" "ssh-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


resource "azapi_resource" "ssh_public_key" {
  type      = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  name      = format("%s%s",var.aks_name,"-sshkey")
  location  = azurerm_resource_group.aks.location
  parent_id = azurerm_resource_group.aks.id
}

resource "azapi_resource_action" "ssh_public_key_gen" {
  type        = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  resource_id = azapi_resource.ssh_public_key.id
  action      = "generateKeyPair"
  method      = "POST"

  response_export_values = ["publicKey"]
}


# This is a bad idea. Keys should go into key vault
output "key_data" {
  value     = azapi_resource.ssh_public_key.body
  sensitive = true
}

# # # Store the secret into the key vault
resource "azurerm_key_vault_secret" "aks-private-key"{
  name  = format("%s-%s",var.aks_name,"sshkey-private")
  value = azapi_resource.ssh_public_key.body
  key_vault_id = azurerm_key_vault.mediawiki.id
}


resource "azurerm_kubernetes_cluster" "mediawiki-k8s" {
  location            = azurerm_resource_group.aks.location
  name                =var.aks_name
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = var.aks_cluster_dns_prefix

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_D2_v2"
    node_count = var.aks_node_count
  }
  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
    }
  }
  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    network_mode = "transparent"
    network_policy = "azure"
  }

  lifecycle {
    ignore_changes = [default_node_pool.0.node_count  ]
  }
}