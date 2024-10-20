resource "azurerm_network_security_group" "merged_nsg" {
  name                = "MergedNSG"
  location            = azurerm_resource_group.rg_obelion.location
  resource_group_name = azurerm_resource_group.rg_obelion.name

  security_rule {
    name                       = "Allow-HTTP-3001"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3001"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "NetworkSgRuleObelion"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-MySQL-3306"
    priority                   = 101
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3306"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "dev"
  }
}

resource "azurerm_subnet_network_security_group_association" "subnet-merged-sg-association" {
  subnet_id                 = azurerm_subnet.subnet_obelion.id
  network_security_group_id = azurerm_network_security_group.merged_nsg.id

  depends_on = [
    azurerm_network_security_group.merged_nsg,
    azurerm_subnet.subnet_obelion
  ]
}
