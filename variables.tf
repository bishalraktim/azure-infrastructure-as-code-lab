variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the Azure virtual network"
  type        = string
}

variable "virtual_network_address_space" {
  description = "Address space for the Azure virtual network"
  type        = list(string)
}

variable "management_subnet_name" {
  description = "Name of the management subnet"
  type        = string
}

variable "management_subnet_address_prefixes" {
  description = "Address prefixes for the management subnet"
  type        = list(string)
}

variable "network_security_group_name" {
  description = "Name of the network security group"
  type        = string
}

variable "management_network_interface_name" {
  description = "Name of the management NIC"
  type        = string
}

variable "management_ip_configuration_name" {
  description = "Name of the management NIC IP configuration"
  type        = string
}

variable "management_private_ip" {
  description = "Static private IP address for the management NIC"
  type        = string
}