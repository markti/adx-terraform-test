data "azuread_client_config" "current" {}

resource "azurerm_kusto_cluster" "main" {
  name                = "adx${local.suffix}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  
  sku {
    name     = "Standard_D13_v2"
    capacity = 2
  }
  double_encryption_enabled   = true
  streaming_ingestion_enabled = true
  engine                      = "V3"
  auto_stop_enabled           = false
}

resource "azurerm_kusto_database" "telemetry" {  
  name                = "telemetry"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  cluster_name        = azurerm_kusto_cluster.main.name
  hot_cache_period    = "P31D"
}


resource "azurerm_kusto_cluster_principal_assignment" "terraform_user" {  
  name                = "terraform-user"
  resource_group_name = azurerm_resource_group.main.name
  cluster_name        = azurerm_kusto_cluster.main.name
  tenant_id           = data.azuread_client_config.current.tenant_id
  principal_id        = data.azuread_client_config.current.client_id
  principal_type      = "App"
  role                = "AllDatabasesAdmin"
}
