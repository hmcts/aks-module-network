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
  service_endpoints    = var.subnet_service_endpoints
}

## AKS-01

resource "azurerm_subnet" "aks_01_subnet" {
  address_prefixes = [var.aks_01_subnet_cidr_blocks]

  name = format("%s-01",
    var.service_shortname
  )

  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  service_endpoints    = var.subnet_service_endpoints

}

## Iaas

resource "azurerm_subnet" "iaas_subnet" {
  address_prefixes = [var.iaas_subnet_cidr_blocks]

  name = "iaas"

  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.virtual_network.name
  service_endpoints                              = var.subnet_service_endpoints
  enforce_private_link_endpoint_network_policies = var.iaas_subnet_enforce_private_link_endpoint_network_policies
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

# Postgres

resource "azurerm_subnet" "postgresql_subnet" {
  address_prefixes = [var.postgresql_subnet_cidr_blocks]

  name = "postgresql"

  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }

  service_endpoints = var.subnet_service_endpoints
}

## Additional Subnets

resource "azurerm_subnet" "additional_subnets" {
  for_each = { for subnet in var.additional_subnets : subnet.name => subnet }

  name                                           = each.value.name
  address_prefixes                               = [each.value.address_prefix]
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.virtual_network.name
  enforce_private_link_endpoint_network_policies = true
}

# Route Table

resource "azurerm_route_table" "route_table" {
  name = format("%s-%s-route-table",
    var.service_shortname,
    var.environment
  )

  location            = var.network_location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_route" "default_route" {
  name                   = var.route_name
  route_table_name       = azurerm_route_table.route_table.name
  resource_group_name    = var.resource_group_name
  address_prefix         = var.route_address_prefix
  next_hop_type          = var.route_next_hop_type
  next_hop_in_ip_address = var.route_next_hop_in_ip_address
}

resource "azurerm_route" "additional_route" {
  for_each = { for route in var.additional_routes : route.name => route }

  name                   = lower(each.value.name)
  route_table_name       = azurerm_route_table.route_table.name
  resource_group_name    = var.resource_group_name
  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = each.value.next_hop_type != "VirtualAppliance" ? null : each.value.next_hop_in_ip_address
}

resource "azurerm_subnet_route_table_association" "aks_00" {
  route_table_id = azurerm_route_table.route_table.id
  subnet_id      = azurerm_subnet.aks_00_subnet.id
}

resource "azurerm_subnet_route_table_association" "aks_01" {
  route_table_id = azurerm_route_table.route_table.id
  subnet_id      = azurerm_subnet.aks_01_subnet.id
}

resource "azurerm_subnet_route_table_association" "iaas" {
  route_table_id = azurerm_route_table.route_table.id
  subnet_id      = azurerm_subnet.iaas_subnet.id
}

resource "azurerm_subnet_route_table_association" "appgw" {
  count          = var.application_gateway_routes == [] ? 0 : 1
  route_table_id = azurerm_route_table.appgw[0].id
  subnet_id      = azurerm_subnet.application_gateway_subnet.id
}

resource "azurerm_route_table" "route_table_appgw" {
  name = format("%s-%s-appgw-route-table",
    var.service_shortname,
    var.environment
  )

  location            = var.network_location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet_route_table_association" "postgresql" {
  route_table_id = azurerm_route_table.route_table.id
  subnet_id      = azurerm_subnet.postgresql_subnet.id
}

resource "azurerm_subnet_route_table_association" "application_gateway_subnet" {
  route_table_id = azurerm_route_table.route_table_appgw.id
  subnet_id      = azurerm_subnet.application_gateway_subnet.id
}

resource "azurerm_route" "additional_route_appgw" {
  for_each = { for route in var.application_gateway_routes : route.name => route }

  name                   = lower(each.value.name)
  route_table_name       = azurerm_route_table.route_table_appgw.name
  resource_group_name    = var.resource_group_name
  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = each.value.next_hop_type != "VirtualAppliance" ? null : each.value.next_hop_in_ip_address
}
