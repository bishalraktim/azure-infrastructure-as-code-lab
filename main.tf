# ============================================================
# Resource Group
# ============================================================

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# ============================================================
# Networking
# ============================================================

resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  address_space       = var.virtual_network_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "management" {
  resource_group_name             = azurerm_resource_group.rg.name
  virtual_network_name            = azurerm_virtual_network.vnet.name
  name                            = var.management_subnet_name
  address_prefixes                = var.management_subnet_address_prefixes
  default_outbound_access_enabled = false
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.network_security_group_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "associate" {
  subnet_id                 = azurerm_subnet.management.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_interface" "nic" {
  name                = var.management_network_interface_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = var.management_ip_configuration_name
    subnet_id                     = azurerm_subnet.management.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.management_private_ip
  }
}

# ============================================================
# Management VM
# ============================================================

resource "azurerm_windows_virtual_machine" "mgmt" {
  name                = "MGMT-VM"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B4ls_v2"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}

# ============================================================
# VPN Gateway / Gateway Subnet / P2S
# ============================================================

resource "azurerm_subnet" "gateway" {
  name                 = var.gateway_subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.gateway_subnet_address_prefixes
}

resource "azurerm_public_ip" "public" {
  name                = var.public_ip_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_virtual_network_gateway" "gateway" {
  name                = var.virtual_network_gateway_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  bgp_enabled   = false
  sku           = "Basic"

  ip_configuration {
    name                          = var.vnet_gateway_config
    public_ip_address_id          = azurerm_public_ip.public.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway.id
  }

  vpn_client_configuration {
    address_space = var.vpn_client_address_space

    root_certificate {
      name             = var.vpn_root_certificate_name
      public_cert_data = var.vpn_root_certificate_data
    }
  }
}