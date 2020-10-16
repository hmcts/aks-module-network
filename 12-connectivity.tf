#--------------------------------------------------------------
# Connectivity
#--------------------------------------------------------------

# Subnets

## AKS-00

resource "azurerm_subnet" "aks_00_subnet" {
  address_prefixes = [var.aks_00_subnet_cidr_blocks]

  name = format("%s-00",
    var.service_shortname
  )

  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
}

## AKS-01

resource "azurerm_subnet" "aks_01_subnet" {
  address_prefixes = [var.aks_01_subnet_cidr_blocks]

  name = format("%s-01",
    var.service_shortname
  )

  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
}

## Iaas 

resource "azurerm_subnet" "iaas_subnet" {
  address_prefixes = [var.iaas_subnet_cidr_blocks]

  name = "iaas"

  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
}

## Application Gateway

resource "azurerm_subnet" "application_gateway_subnet" {
  address_prefixes = [var.application_gateway_subnet_cidr_blocks]

  name = format("%s-appgw",
    var.service_shortname
  )

  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
}

# Route Table

resource "azurerm_route_table" "route_table" {
  name = format("%s-%s-route-table",
    var.service_shortname,
    var.environment
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

resource "azurerm_subnet_route_table_association" "aks_00" {
  route_table_id = azurerm_route_table.route_table.id
  subnet_id = azurerm_subnet.aks_00_subnet.id
}

resource "azurerm_subnet_route_table_association" "aks_01" {
  route_table_id = azurerm_route_table.route_table.id
  subnet_id = azurerm_subnet.aks_01_subnet.id
}
