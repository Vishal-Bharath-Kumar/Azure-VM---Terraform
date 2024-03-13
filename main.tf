resource "azurerm_resource_group" "az_resource_grp" {
  name     = var.resource_group_name
  location = "East US"
}
resource "azurerm_virtual_network" "az_vn" {
    name = var.az_vn_name
    resource_group_name = azurerm_resource_group.az_resource_grp.name
    location = azurerm_resource_group.az_resource_grp.location
    address_space = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "az_subnet" {
    name = var.az_subnet_name
    resource_group_name = azurerm_resource_group.az_resource_grp.name
    virtual_network_name = azurerm_virtual_network.az_vn.name
    address_prefixes = ["10.0.1.0/24"]
}
resource "azurerm_public_ip" "az_public_ip" {
    name = var.az_public_ip_name
    resource_group_name = azurerm_resource_group.az_resource_grp.name
    location = azurerm_resource_group.az_resource_grp.location
    allocation_method = "Static"
}
resource "azurerm_network_interface" "az_inetwork" {
    name = var.az_inetwork_name
    resource_group_name = azurerm_resource_group.az_resource_grp.name
    location = azurerm_resource_group.az_resource_grp.location
    ip_configuration {
      name = "internal"
      private_ip_address_allocation = "Dynamic"
      subnet_id = azurerm_subnet.az_subnet.id
      public_ip_address_id = azurerm_public_ip.az_public_ip.id
    }
    depends_on = [ azurerm_virtual_network.az_vn,
    azurerm_public_ip.az_public_ip ]
}
resource "azurerm_linux_virtual_machine" "az_linux_vm" {
    name = var.az_linux_vm_name
    resource_group_name = azurerm_resource_group.az_resource_grp.name
    location = azurerm_resource_group.az_resource_grp.location
    size = "Standard_D2s_v3"
    network_interface_ids = [azurerm_network_interface.az_inetwork.id]
    admin_username = "vishal"
    admin_password = "Vishalspark@2001"
    disable_password_authentication = "false"
    os_disk {
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference {
      publisher = "Canonical"
      offer = "UbuntuServer"
      sku = "18.04-LTS"
      version = "Latest"
    }
}

