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
  description = "Map of additional subnets to create, keyed by the subnet name."
  type = list(object({
    name                              = string
    address_prefix                    = string
    service_endpoints                 = optional(list(string))
    private_endpoint_network_policies = optional(string, "Disabled")
    associate_route_table             = optional(bool, false)
    delegations = optional(map(object({
      service_name = string,
      actions      = list(string)
    })))
    nsg_rules = optional(list(object({
      name                         = string
      priority                     = number
      direction                    = string
      access                       = string
      protocol                     = string
      source_port_range            = optional(string)
      source_port_ranges           = optional(list(string))
      destination_port_range       = optional(string)
      destination_port_ranges      = optional(list(string))
      source_address_prefix        = optional(string)
      source_address_prefixes      = optional(list(string))
      destination_address_prefix   = optional(string)
      destination_address_prefixes = optional(list(string))
    })), [])
  }))
  default = []

  validation {
    condition = alltrue(flatten([
      for subnet in var.additional_subnets : [
        for rule in coalesce(subnet.nsg_rules, []) :
        (rule.source_port_range == null || rule.source_port_ranges == null) &&
        (rule.destination_port_range == null || rule.destination_port_ranges == null) &&
        (rule.source_address_prefix == null || rule.source_address_prefixes == null) &&
        (rule.destination_address_prefix == null || rule.destination_address_prefixes == null)
      ]
    ]))
    error_message = "For each nsg_rule, set only the singular (e.g. source_port_range) OR the plural (e.g. source_port_ranges) form, not both. This applies to source_port_range/ranges, destination_port_range/ranges, source_address_prefix/prefixes, and destination_address_prefix/prefixes."
  }

  validation {
    condition = alltrue(flatten([
      for subnet in var.additional_subnets : [
        for rule in coalesce(subnet.nsg_rules, []) :
        (rule.source_port_range != null || rule.source_port_ranges != null) &&
        (rule.destination_port_range != null || rule.destination_port_ranges != null) &&
        (rule.source_address_prefix != null || rule.source_address_prefixes != null) &&
        (rule.destination_address_prefix != null || rule.destination_address_prefixes != null)
      ]
    ]))
    error_message = "For each nsg_rule, you must set one of source_port_range/ranges, one of destination_port_range/ranges, one of source_address_prefix/prefixes, and one of destination_address_prefix/prefixes."
  }
}

variable "additional_routes_application_gateway" {
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = string
  }))

  default = []
}

variable "iaas_subnet_enforce_private_link_endpoint_network_policies" {
  default = "Disabled"
  type    = string

  validation {
    condition     = contains(["Disabled", "Enabled", "NetworkSecurityGroupEnabled", "RouteTableEnabled"], var.iaas_subnet_enforce_private_link_endpoint_network_policies)
    error_message = "The iaas_subnet_enforce_private_link_endpoint_network_policies must be one of: Disabled, Enabled, NetworkSecurityGroupEnabled, or RouteTableEnabled."
  }
}
