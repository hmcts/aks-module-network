data "null_data_source" "connectivity_outputs" {
  inputs = {
    aks_00_subnet_id                                = azurerm_subnet.aks_00_subnet.id
    aks_00_subnet_name                              = azurerm_subnet.aks_00_subnet.name
    aks_00_subnet_resource_group_name               = azurerm_subnet.aks_00_subnet.resource_group_name
    aks_00_subnet_virtual_network_name              = azurerm_subnet.aks_00_subnet.virtual_network_name
    aks_00_subnet_address_prefix                    = azurerm_subnet.aks_00_subnet.address_prefix
    aks_01_subnet_id                                = azurerm_subnet.aks_01_subnet.id
    aks_01_subnet_name                              = azurerm_subnet.aks_01_subnet.name
    aks_01_subnet_resource_group_name               = azurerm_subnet.aks_01_subnet.resource_group_name
    aks_01_subnet_virtual_network_name              = azurerm_subnet.aks_01_subnet.virtual_network_name
    aks_01_subnet_address_prefix                    = azurerm_subnet.aks_01_subnet.address_prefix
    iaas_subnet_id                                  = azurerm_subnet.iaas_subnet.id
    iaas_subnet_name                                = azurerm_subnet.iaas_subnet.name
    iaas_subnet_resource_group_name                 = azurerm_subnet.iaas_subnet.resource_group_name
    iaas_subnet_virtual_network_name                = azurerm_subnet.iaas_subnet.virtual_network_name
    iaas_subnet_address_prefix                      = azurerm_subnet.iaas_subnet.address_prefix
    application_gateway_subnet_id                   = azurerm_subnet.application_gateway_subnet.id
    application_gateway_subnet_name                 = azurerm_subnet.application_gateway_subnet.name
    application_gateway_subnet_resource_group_name  = azurerm_subnet.application_gateway_subnet.resource_group_name
    application_gateway_subnet_virtual_network_name = azurerm_subnet.application_gateway_subnet.virtual_network_name
    application_gateway_subnet_address_prefix       = azurerm_subnet.application_gateway_subnet.address_prefix
  }
}
