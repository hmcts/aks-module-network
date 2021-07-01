variable "enable_debug" {
  default = "true"
}
variable "route_name" {
  default = "default"
}
variable "route_address_prefix" {
  default = "0.0.0.0/0"
}
variable "route_next_hop_type" {
  default = "VirtualAppliance"
}
variable "route_next_hop_in_ip_address" {
  default = "10.10.1.1"
}

variable "additional_routes" {
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = string
  }))

  default = []
}

variable "subnets" {
  type = list(object({
    name                                           = string
    address_prefix                                 = string
    subnet_service_endpoints                       = bool
    enforce_private_link_endpoint_network_policies = bool
    route_table                                    = bool
  }))

  default = []
}

variable "additional_routes_appgw" {
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = string
  }))

  default = []
}