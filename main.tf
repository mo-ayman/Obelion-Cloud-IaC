# Create a Resource Group
resource "azurerm_resource_group" "rg_obelion" {
  name     = "RgObelion"
  location = "westus"
}

# Create a Virtual Network (VNet)
resource "azurerm_virtual_network" "vnet_obelion" {
  name                = "VnetObelion"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg_obelion.location
  resource_group_name = azurerm_resource_group.rg_obelion.name

  depends_on = [
    azurerm_resource_group.rg_obelion
  ]
}

# Create a Subnet
resource "azurerm_subnet" "subnet_obelion" {
  name                 = "SubnetObelion"
  resource_group_name  = azurerm_resource_group.rg_obelion.name
  virtual_network_name = azurerm_virtual_network.vnet_obelion.name
  address_prefixes     = ["10.0.1.0/24"]

  depends_on = [
    azurerm_virtual_network.vnet_obelion,
    azurerm_resource_group.rg_obelion
  ]
}

# resource "azurerm_network_security_group" "network_sg_obelion" {
#   name                = "NetworkSgObelion"
#   resource_group_name = azurerm_resource_group.rg_obelion.name
#   location            = azurerm_resource_group.rg_obelion.location

#   tags = {
#     environment = "dev"
#   }

#   depends_on = [
#     azurerm_resource_group.rg_obelion
#   ]
# }

# resource "azurerm_network_security_rule" "network_sg_rule" {
#   name                        = "NetworkSgRuleObelion"
#   network_security_group_name = azurerm_network_security_group.network_sg_obelion.name
#   resource_group_name         = azurerm_resource_group.rg_obelion.name
#   priority                    = 100
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "*"
#   source_port_range           = "*"
#   destination_port_range      = "*"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"

#   depends_on = [
#     azurerm_network_security_group.network_sg_obelion,
#     azurerm_resource_group.rg_obelion
#   ]
# }



