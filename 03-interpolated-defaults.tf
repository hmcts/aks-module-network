data "azurerm_client_config" "current" {}

locals {
  slug_location = lower(replace(var.network_location, " ", "."))
}

