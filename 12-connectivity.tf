#--------------------------------------------------------------
# Connectivity
#--------------------------------------------------------------

# Subnets

## AKS-00

resource "azurerm_subnet" "aks_00_subnet" {
  address_prefix = var.aks_00_subnet_cidr_blocks

  name = format("%s_aks_00_%s",
    lookup(data.null_data_source.network_defaults.inputs, "name_prefix"),
    var.deploy_environment
  )

  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
}

## AKS-01

resource "azurerm_subnet" "aks_01_subnet" {
  address_prefix = var.aks_01_subnet_cidr_blocks

  name = format("%s_aks_01_%s",
    lookup(data.null_data_source.network_defaults.inputs, "name_prefix"),
    var.deploy_environment
  )

  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
}

## Iaas 

resource "azurerm_subnet" "iaas_subnet" {
  address_prefix = var.iaas_subnet_cidr_blocks

  name = format("%s_iaas_%s",
    lookup(data.null_data_source.network_defaults.inputs, "name_prefix"),
    var.deploy_environment
  )

  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
}

## Application Gateway

resource "azurerm_subnet" "application_gateway_subnet" {
  address_prefix = var.application_gateway_subnet_cidr_blocks

  name = format("%s_application_gateway_%s",
    lookup(data.null_data_source.network_defaults.inputs, "name_prefix"),
    var.deploy_environment
  )

  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
}

# Route Table

resource "azurerm_route_table" "route_table" {
  name = format("%s_route_table_%s",
    lookup(data.null_data_source.network_defaults.inputs, "name_prefix"),
    var.deploy_environment
  )

  location            = var.network_location
  resource_group_name = var.resource_group_name

  route {
    name                   = var.route_name
    address_prefix         = var.route_address_prefix
    next_hop_type          = var.route_next_hop_type
    next_hop_in_ip_address = var.route_next_hop_in_ip_address
  }
}
