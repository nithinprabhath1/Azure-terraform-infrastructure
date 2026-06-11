# WAF POLICY

resource "azurerm_web_application_firewall_policy" "waf_policy" {
  name                = "waf-policy-production"
  resource_group_name = azurerm_resource_group.net.name
  location            = azurerm_resource_group.net.location

  policy_settings {
    enabled                     = true
    mode                        = "Prevention"
    request_body_check          = true
    max_request_body_size_in_kb = 128
    file_upload_limit_in_mb     = 100
  }

  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
    }
  }
}

### PUBLIC IP FOR APP GATEWAY

resource "azurerm_public_ip" "appgw_pip" {
  name                = "pip-appgw-01"
  resource_group_name = azurerm_resource_group.net.name
  location            = azurerm_resource_group.net.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

#### APPLICATION GATEWAY

resource "azurerm_application_gateway" "appgw" {
  name                = "appgw-production"
  resource_group_name = azurerm_resource_group.net.name
  location            = azurerm_resource_group.net.location
  firewall_policy_id  = azurerm_web_application_firewall_policy.waf_policy.id

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = azurerm_subnet.appgw.id
  }

  frontend_port {
    name = "port-80"
    port = 80
  }

  frontend_port {
    name = "port-443"
    port = 443
  }

  frontend_ip_configuration {
    name                 = "appgw-frontend-ip"
    public_ip_address_id = azurerm_public_ip.appgw_pip.id
  }

  backend_address_pool {
    name = "web-backend-pool"
    ip_addresses = [
      azurerm_network_interface.nic_web.private_ip_address
    ]
  }

  backend_address_pool {
    name = "app-backend-pool"
    ip_addresses = [
      azurerm_network_interface.nic_app.private_ip_address
    ]
  }

  backend_http_settings {
    name                  = "web-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "web-listener"
    frontend_ip_configuration_name = "appgw-frontend-ip"
    frontend_port_name             = "port-80"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "web-routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "web-listener"
    backend_address_pool_name  = "web-backend-pool"
    backend_http_settings_name = "web-http-settings"
    priority                   = 100
  }
}
