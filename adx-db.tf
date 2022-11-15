
resource "azurerm_kusto_database" "telemetry" {  
  name                = "telemetry"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  cluster_name        = azurerm_kusto_cluster.main.name
  hot_cache_period    = "P31D"
}