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

variable "additional_subnets" {
  type = list(object({
    name                   = string
    address_prefix         = string
    additional_subnets_priv_link_pol = bool
  }))

    default = []
}
