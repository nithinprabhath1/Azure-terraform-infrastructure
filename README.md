# Azure Infrastructure Project — Terraform

A production-ready Azure infrastructure deployed using Terraform, following enterprise security best practices.

## Architecture

Internet → Application Gateway (WAF V2)
↓
┌─────────────────────┐
│ --rg-networking │
│ vnet-production │
│ ├── subnet-web │ ← NSG: Allow 80, 443
│ ├── subnet-app │ ← NSG: Allow from web only
│ ├── subnet-db │ ← NSG: Allow 1433 from app only
│ └── subnet-appgw │ ← Application Gateway
│ vnet-dev │
│ ├── subnet-dev-pub │ ← NSG: Allow RDP
│ └── subnet-dev-prv │
└─────────────────────┘
┌─────────────────────┐
│ --rg-production │
│ ├── vm-web-01 │ ← Windows Web Server
│ └── vm-app-01 │ ← Windows App Server
└─────────────────────┘
┌─────────────────────┐
│ --rg-dev │
│ └── vm-dev-01 │ ← Windows Dev Machine
└─────────────────────┘

## Resources Created

| Resource                | Count | Details                                      |
| ----------------------- | ----- | -------------------------------------------- |
| Resource Groups         | 3     | Networking, Production, Dev                  |
| Virtual Networks        | 2     | Production (10.0.0.0/16), Dev (10.1.0.0/16)  |
| Subnets                 | 6     | Web, App, DB, AppGW, Dev-Public, Dev-Private |
| Network Security Groups | 4     | One per subnet with strict rules             |
| Application Gateway     | 1     | WAF V2 with OWASP 3.2 ruleset                |
| WAF Policy              | 1     | Prevention mode                              |
| Windows VMs             | 3     | Web, App, Dev servers                        |
| Key Vault               | 1     | Stores VM secrets securely                   |
| Storage Account         | 1     | Logs and backups containers                  |
| Public IP               | 1     | Application Gateway frontend                 |

## Security Design

- **No direct Public IPs on VMs** — all traffic goes through App Gateway
- **WAF V2 Prevention mode** — blocks OWASP Top 10 attacks
- **NSG per subnet** — least privilege network access
- **Key Vault** — secrets never hardcoded in code
- **Private subnets** for app and database layers

## Tech Stack

- Terraform ~> 4.74.0
- Azure Provider (azurerm)
- Azure East US region

## Project Structure

├── 1. provider.tf # Azure provider + subscription
├── 2. variables.tf # All variables (object style)
├── 3. resource_groups.tf # 3 resource groups
├── 4. vnet.tf # 2 virtual networks
├── 5. subnet.tf # 6 subnets
├── 6. nsg.tf # 4 NSGs + subnet associations
├── 7. network_interface.tf # 3 NICs
├── 8. virtual_machine_win.tf # Windows VMs
├── 9. app_gateway.tf # WAF policy + App Gateway
├── 10. storage_account.tf # Storage + containers
├── key_vault.tf # Key Vault + secrets
└── outputs.tf # Resource outputs

## How to Deploy

### Prerequisites

- Terraform installed
- Azure CLI installed
- Azure account

### Deploy

```bash
az login
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```

### Destroy

```bash
terraform destroy -auto-approve
```

## Author

**Nithin Prabhath**
DevOps & Cloud Engineer
