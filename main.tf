resource "random_string" "random" {
  length  = 6
  special = false
  lower   = true
  upper   = false
}

locals {
  suffix = random_string.random.result
}

resource "azurerm_resource_group" "main" {
  name      = "rg-aks-${local.suffix}"
  location  = var.location
}
