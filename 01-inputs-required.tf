variable "resource_group_name" {}

variable "network_location" {}
variable "network_shortname" {}
variable "network_address_space" {}
variable "service_name_prefix" {}
# variable "dns_suffix" {}

variable "aks_00_subnet_cidr_blocks" {}
variable "aks_01_subnet_cidr_blocks" {}
variable "iaas_subnet_cidr_blocks" {}
variable "application_gateway_subnet_cidr_blocks" {}

variable "deploy_environment" {}

# Tags
variable "tag_project_name" {}

variable "tag_environment" {}
variable "tag_cost_center" {}
variable "tag_app_operations_owner" {}
variable "tag_system_owner" {}
variable "tag_budget_owner" {}
