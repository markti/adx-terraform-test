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
