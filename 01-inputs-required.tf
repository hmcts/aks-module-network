variable "resource_group_name" {}

variable "network_location" {}
variable "network_shortname" {}
variable "network_address_space" {}
variable "subnet_service_endpoints" {
  default = [
    "Microsoft.Storage",
    "Microsoft.KeyVault",
    "Microsoft.Sql"
  ]
}

variable "iaas_subnet_enforce_private_link_endpoint_network_policies" {
  default = true
}

variable "subnets" {
  type = list(object({
    name                                           = string
    address_prefix                                 = string
    subnet_service_endpoints                       = bool
    enforce_private_link_endpoint_network_policies = bool
    route_table                                    = bool
  }))
}

variable "environment" {}
variable "project" {}
variable "service_shortname" {}

# Tags
variable "tags" {}