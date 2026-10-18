# Azure Infrastructure as Code Lab

Hands-on Azure Infrastructure as Code lab using Terraform, Git, GitHub and cloud engineering practices.

## Current Architecture

- Resource Group: `rg-iac-lab`
- Virtual Network: `vnet-iac-lab`
  - Address space: `10.20.0.0/16`
- Management Subnet: `snet-management`
  - Address prefix: `10.20.1.0/24`
  - Default outbound access disabled
- Network Security Group: `nsg-management`
  - Associated with `snet-management`
- Management NIC: `nic-mgmt-01`
  - IP configuration: `ipconfig-mgmt`
  - Static private IP: `10.20.1.10`

## Current Status

The core management network infrastructure has been deployed successfully using Terraform.

Terraform currently manages:

- Azure Resource Group
- Virtual Network
- Management Subnet
- Network Security Group
- NSG to subnet association
- Management Network Interface

## Next Step

Create a Windows management virtual machine and attach it to `nic-mgmt-01`.

The management VM will initially use private networking only. Secure administrative access will be designed separately rather than exposing RDP directly to the Internet.

## Planned Improvements

Future stages of the lab will include:

- Additional application and data subnets
- Network security rules
- Secure management connectivity
- Controlled outbound Internet access
- Terraform outputs
- Remote Terraform state in Azure Storage
- Reusable Terraform modules
- Monitoring and logging
- GitHub Actions CI/CD