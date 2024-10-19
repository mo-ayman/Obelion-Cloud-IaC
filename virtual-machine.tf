
# Create Backend Virtual Machine
resource "azurerm_linux_virtual_machine" "backend_vm" {
  name                = "BackendVM"
  resource_group_name = azurerm_resource_group.rg_obelion.name
  location            = azurerm_resource_group.rg_obelion.location
  size                = "Standard_B1s" # 1 core, 1 GB RAM
  admin_username      = "azureuser"
  admin_password      = "Password12345!" # Use a secure password or key


  custom_data = filebase64("backend.sh") # This will execute the script

  network_interface_ids = [
    azurerm_network_interface.backend_nic.id
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching = "ReadWrite"
    # disk_size_gb  = 30 # 8 GB disk
    storage_account_type = "Premium_LRS"

  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  depends_on = [
    azurerm_network_interface.backend_nic,
    azurerm_resource_group.rg_obelion

  ]
}

# Create Frontend Virtual Machine
resource "azurerm_linux_virtual_machine" "frontend_vm" {
  name                = "FrontendVM"
  resource_group_name = azurerm_resource_group.rg_obelion.name
  location            = azurerm_resource_group.rg_obelion.location
  size                = "Standard_B1s" # 1 core, 1 GB RAM
  admin_username      = "azureuser"
  admin_password      = "Password12345!" # Use a secure password or key
  network_interface_ids = [
    azurerm_network_interface.frontend_nic.id
  ]

  custom_data = filebase64("frontend.sh") # This will execute the script


  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching = "ReadWrite"
    ##  disk_size_gb  = 30 # 8 GB disk
    storage_account_type = "Premium_LRS"

  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"

  }



  depends_on = [
    azurerm_network_interface.frontend_nic,
    azurerm_resource_group.rg_obelion

  ]
}
