provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.mediawiki-k8s.kube_config.0.host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.mediawiki-k8s.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.mediawiki-k8s.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.mediawiki-k8s.kube_config.0.cluster_ca_certificate)
  }
}



  
resource "helm_release" "mediawiki-bitnami" {
  name = "mediawiki"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "mediawiki"

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

    set {
    name  = "mediawikiUsername"
    value = "admin"
  }

   set {
    name  = "mediawikiPassword"
    value = random_password.mysql.result
  }

  set {
    name  = "mediawikiEmail"
    value = "admin@example.com"
  }

   set {
    name  = "externalDatabase.host"
    value = azurerm_mysql_flexible_server.mediawiki.fqdn
  }

  set {
    name  = "mediawikiDatabaseName"
    value = "my_wiki"
  }

  set {
    name  = "externalDatabase.user"
    value = "sqladmin"
  }

  set {
    name  = "externalDatabase.password"
    value = random_password.mysql.result
  }

  set {
    name  = "externalDatabase.database"
    value = var.mysql_db_name
  }

  set {
    name  = "externalDatabase.port"
    value = "3306"
  }
 set {
    name = "mariadb.enabled"
    value = "true"
  }
}