#--------------------------------------------------------------
# Connectivity
#--------------------------------------------------------------

## Subnets

resource "azurerm_subnet" "subnets" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }

  name                                           = each.value.name
  address_prefixes                               = [each.value.address_prefix]
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.virtual_network.name
  enforce_private_link_endpoint_network_policies = each.value.enforce_private_link_endpoint_network_policies
  service_endpoints                              = each.value.subnet_service_endpoints
}

# Route Table

resource "azurerm_route_table" "route_table" {
  name = format("%s-%s-route-table",
    var.service_shortname,
    var.environment
  )

  location            = var.network_location
  resource_group_name = var.resource_group_name
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

resource "azurerm_subnet_route_table_association" "route_table" {
  for_each = { for subnet in var.subnets : subnet.name => subnet
    if subnet.route_table == true
  }

  route_table_id = azurerm_route_table.route_table.id
  subnet_id      = azurerm_subnet.subnets[each.value.name].id

}