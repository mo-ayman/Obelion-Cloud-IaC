resource "azurerm_private_dns_zone" "mysql_private_dns_zone" {
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.rg_obelion.name

  depends_on = [
    azurerm_resource_group.rg_obelion
  ]
}

resource "azurerm_private_dns_zone_virtual_network_link" "mysql_vnet_link" {
  name                  = "mysql_vnet_link"
  resource_group_name   = azurerm_resource_group.rg_obelion.name
  private_dns_zone_name = azurerm_private_dns_zone.mysql_private_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet_obelion.id

  depends_on = [
    azurerm_resource_group.rg_obelion,
    azurerm_private_dns_zone.mysql_private_dns_zone,
    azurerm_virtual_network.vnet_obelion
  ]
}


resource "azurerm_mysql_flexible_server" "mysql_server" {
  name                   = "mysql-serverr"
  location               = azurerm_resource_group.rg_obelion.location
  resource_group_name    = azurerm_resource_group.rg_obelion.name
  administrator_login    = var.DB_USER_NAME
  administrator_password = var.DB_PASSWORD
  version                = "8.0.21"
  sku_name               = "B_Standard_B1ms" # Lowest plan


  depends_on = [
    azurerm_resource_group.rg_obelion,
    azurerm_subnet.subnet_obelion,
    azurerm_private_dns_zone.mysql_private_dns_zone
  ]
}



resource "azurerm_mysql_flexible_server_firewall_rule" "allow_internal_access" {
  name                = "internal_access"
  resource_group_name = azurerm_resource_group.rg_obelion.name
  server_name         = azurerm_mysql_flexible_server.mysql_server.name # <-- Add this line

  start_ip_address = "10.0.0.0"
  end_ip_address   = "10.255.255.255" # Allow access only from the internal network

  depends_on = [
    azurerm_mysql_flexible_server.mysql_server,
    azurerm_resource_group.rg_obelion
  ]
}

resource "azurerm_private_endpoint" "mysql_private_endpoint" {
  name                = "mysql-private-endpoint"
  location            = azurerm_resource_group.rg_obelion.location
  resource_group_name = azurerm_resource_group.rg_obelion.name
  subnet_id           = azurerm_subnet.subnet_obelion.id # Ensure this is a subnet with a delegated private IP space

  private_service_connection {
    name                           = "mysqlPrivateLink"
    private_connection_resource_id = azurerm_mysql_flexible_server.mysql_server.id
    subresource_names              = ["mysqlServer"]
    is_manual_connection           = false
  }

  depends_on = [
    azurerm_resource_group.rg_obelion,
    azurerm_mysql_flexible_server.mysql_server,
    azurerm_subnet.subnet_obelion
  ]
}

