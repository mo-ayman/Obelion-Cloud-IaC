
# Create Public IP for Backend Machine
resource "azurerm_public_ip" "backend_ip" {
  name                = "BackendPublicIP"
  location            = azurerm_resource_group.rg_obelion.location
  resource_group_name = azurerm_resource_group.rg_obelion.name

  allocation_method = "Static"
  ip_version        = "IPv4"

  depends_on = [
    azurerm_resource_group.rg_obelion

  ]
}

# Create Public IP for Frontend Machine
resource "azurerm_public_ip" "frontend_ip" {
  name                = "FrontendPublicIP"
  location            = azurerm_resource_group.rg_obelion.location
  resource_group_name = azurerm_resource_group.rg_obelion.name

  allocation_method = "Static"
  ip_version        = "IPv4"

  depends_on = [
    azurerm_resource_group.rg_obelion

  ]
}

# Create Network Interface for Backend Machine
resource "azurerm_network_interface" "backend_nic" {
  name                = "BackendNIC"
  location            = azurerm_resource_group.rg_obelion.location
  resource_group_name = azurerm_resource_group.rg_obelion.name

  ip_configuration {
    name                          = "BackendIPConfig"
    subnet_id                     = azurerm_subnet.subnet_obelion.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.backend_ip.id
  }

  depends_on = [
    azurerm_subnet.subnet_obelion,
    azurerm_public_ip.backend_ip,
    azurerm_resource_group.rg_obelion

  ]
}

# Create Network Interface for Frontend Machine
resource "azurerm_network_interface" "frontend_nic" {
  name                = "FrontendNIC"
  location            = azurerm_resource_group.rg_obelion.location
  resource_group_name = azurerm_resource_group.rg_obelion.name

  ip_configuration {
    name                          = "FrontendIPConfig"
    subnet_id                     = azurerm_subnet.subnet_obelion.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.frontend_ip.id
  }

  depends_on = [
    azurerm_subnet.subnet_obelion,
    azurerm_public_ip.frontend_ip,
    azurerm_resource_group.rg_obelion

  ]
}

