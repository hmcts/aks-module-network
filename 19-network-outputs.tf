output "network_id" {
  value = azurerm_virtual_network.virtual_network.id
}

output "additional_subnet_nsg_ids" {
  description = "Map of NSG IDs keyed by subnet name, for additional subnets that have NSG rules defined."
  value       = { for k, v in azurerm_network_security_group.additional_subnet_nsg : k => v.id }
}

output "network_name" {
  value = azurerm_virtual_network.virtual_network.name
}

output "network_resource_group" {
  value = azurerm_virtual_network.virtual_network.resource_group_name
}
