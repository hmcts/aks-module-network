variable "resource_group_name" {}

variable "network_location" {}
variable "network_shortname" {}
variable "network_address_space" {}
variable "aks_00_subnet_cidr_blocks" {}
variable "aks_01_subnet_cidr_blocks" {}
variable "iaas_subnet_cidr_blocks" {}
variable "application_gateway_subnet_cidr_blocks" {}

variable "environment" {}
variable "project" {}
variable "service_shortname" {}

# Tags
variable "tag" {}

