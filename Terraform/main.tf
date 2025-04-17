provider "azurerm" {
  features {}
  subscription_id = "fa23df80-990d-4e5f-bf9b-1b3ae6e405a1"
}

resource "azurerm_resource_group" "main" {
  name     = "my-rg"
  location = "East US 2"
}

resource "azurerm_container_registry" "acr" {
  name                = "acratul0110"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aksatul0110"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "dotnetaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }
}
