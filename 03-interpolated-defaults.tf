data "azurerm_client_config" "current" {}

locals {
  slug_location = lower(replace(var.network_location, " ", "."))

  additional_subnet_routes = flatten([
    for idx, config in var.additional_subnets : [
      for g in config.routes : merge(g, { subnetname = config.name })
    ]

 ])

  additional_route_table = flatten([
    for idx, config in var.additional_subnets : config.name if  config.routes != []

  ])
}

