data "null_data_source" "debug_outputs" {
  count = var.enable_debug == "true" ? 1 : 0

  inputs = {
    # inputs-required
    network_location            = var.network_location
    network_shortname           = var.network_shortname
    network_address_space       = var.network_address_space
    aks_00_subnet_cidr_blocks   = var.aks_00_subnet_cidr_blocks
    aks_01_subnet_cidr_blocks   = var.aks_01_subnet_cidr_blocks
    iaas_subnet_cidr_blocks     = var.iaas_subnet_cidr_blocks
    deploy_environment          = var.deploy_environment

    # inputs-default
    enable_debug = var.enable_debug

    # interpolated-defaults
    name_prefix = lookup(data.null_data_source.network_defaults.inputs, "name_prefix")
  }
}

output "debug_config" {
  value = data.null_data_source.debug_outputs.*.inputs
}
