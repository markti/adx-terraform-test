
resource "azurerm_kusto_cluster_principal_assignment" "terraform_user" {  
  name                = "terraform-user"
  resource_group_name = azurerm_resource_group.main.name
  cluster_name        = azurerm_kusto_cluster.main.name
  tenant_id           = data.azuread_client_config.current.tenant_id
  principal_id        = data.azuread_client_config.current.client_id
  principal_type      = "App"
  role                = "AllDatabasesAdmin"
}


resource "azurerm_kusto_cluster_principal_assignment" "admin_user" {  
  name                = "admin-user"
  resource_group_name = azurerm_resource_group.main.name
  cluster_name        = azurerm_kusto_cluster.main.name
  tenant_id           = data.azuread_client_config.current.tenant_id
  principal_id        = var.admin_user
  principal_type      = "User"
  role                = "AllDatabasesAdmin"
}