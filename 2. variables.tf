# LOCATION
variable "location" {
  description = "Primary location for all resources"
  default     = "East US"
}

# RESOURCE GROUP NAMES
variable "resource_groups" {
  default = {
    net   = "rg-networking"
    prod  = "rg-production"
    dev   = "rg-dev"
  }
}

# VNET NAMES & ADDRESS SPACES
variable "prod_vnet" {
  default = {
    name    = "vnet-production"
    address = "10.0.0.0/16"
  }
}

variable "dev_vnet" {
  default = {
    name    = "vnet-dev"
    address = "10.1.0.0/16"
  }
}

# SUBNETS
variable "prod_sub" {
  default = {
    web_publ = {
      name   = "subnet-web-public"
      prefix = "10.0.1.0/24"
    }
    app_prvt = {
      name   = "subnet-app-private"
      prefix = "10.0.2.0/24"
    }
    db_prvt = {
      name   = "subnet-db-private"
      prefix = "10.0.3.0/24"
    }
    appgw = {
      name   = "subnet-appgw"
      prefix = "10.0.4.0/24"
    }
  }
}

variable "dev_sub" {
  default = {
    dev_publ = {
      name   = "subnet-dev-public"
      prefix = "10.1.1.0/24"
    }
    dev_prvt = {
      name   = "subnet-dev-private"
      prefix = "10.1.2.0/24"
    }
  }
}

# VIRTUAL MACHINE SIZE
variable "vm_size" {
  description = "Size of all virtual machines"
  default     = "Standard_D2s_v7"
}
