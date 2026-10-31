# ============================================================
# General / Resource Group
# ============================================================

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
}

# ============================================================
# Virtual Network
# ============================================================

variable "virtual_network_name" {
  description = "Name of the Azure virtual network"
  type        = string
}

variable "virtual_network_address_space" {
  description = "Address space for the Azure virtual network"
  type        = list(string)
}

# ============================================================
# Management Subnet
# ============================================================

variable "management_subnet_name" {
  description = "Name of the management subnet"
  type        = string
}

variable "management_subnet_address_prefixes" {
  description = "Address prefixes for the management subnet"
  type        = list(string)
}

# ============================================================
# Network Security Group
# ============================================================

variable "network_security_group_name" {
  description = "Name of the network security group"
  type        = string
}

# ============================================================
# Management Network Interface
# ============================================================

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

# ============================================================
# Management Virtual Machine
# ============================================================

variable "admin_username" {
  description = "VM admin name"
  type        = string
}

variable "admin_password" {
  description = "VM login password"
  type        = string
  sensitive   = true
}

# ============================================================
# VPN Gateway / Gateway Subnet / P2S
# ============================================================

variable "gateway_subnet_name" {
  description = "Name of the gateway subnet"
  type        = string
}

variable "gateway_subnet_address_prefixes" {
  description = "Address prefixes for the gateway subnet"
  type        = list(string)
}

variable "public_ip_name" {
  description = "Name of the public IP"
  type        = string
}

variable "virtual_network_gateway_name" {
  description = "Name of the virtual network gateway"
  type        = string
}

variable "vnet_gateway_config" {
  description = "Name of the vnet gateway configuration"
  type        = string
}

variable "vpn_client_address_space" {
  description = "VPN client address space"
  type        = list(string)
}

variable "vpn_root_certificate_name" {
  description = "Name of the P2S VPN root certificate"
  type        = string
}

variable "vpn_root_certificate_data" {
  description = "Base64 encoded public root certificate data for P2S VPN"
  type        = string
}



