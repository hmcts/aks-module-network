#--------------------------------------------------------------
# Network
#--------------------------------------------------------------

resource "azurerm_virtual_network" "virtual_network" {
  address_space = [
    var.network_address_space,
    "10.101.128.0/17"
  ]

  location = var.network_location

  name = format("%s-%s-vnet",
    var.project,
    var.environment
  )

  resource_group_name = var.resource_group_name

  tags = var.tags
}
