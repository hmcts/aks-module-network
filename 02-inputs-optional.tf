variable "enable_debug" {
  default = "true"
}
variable "route_name" {
  default = "default"
}
variable "route_address_prefix" {
  default = "10.100.0.0/14"
}
variable "route_next_hop_type" {
  default = "VirtualAppliance"
}
variable "route_next_hop_in_ip_address" {
  default = "10.10.1.1"
}
