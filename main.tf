# Create Resource Group
resource "azurerm_resource_group" "aks_rg" {
  name     = "aks-resource-group"
  location = "Central India"
}


# Create Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                = "mycontainerregistry2121"
  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = azurerm_resource_group.aks_rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

# Create AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-cluster"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "aksdns"
  kubernetes_version  = "1.29.7" # Use the desired Kubernetes version

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
    os_disk_size_gb = 30
    type       = "VirtualMachineScaleSets"  # For scaling flexibility
    max_pods   = 30
  }

  network_profile {
    network_plugin = "azure" # Use Azure CNI
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
  }

  identity {
    type = "SystemAssigned"
  }


  tags = {
    Environment = "Dev"
  }
}