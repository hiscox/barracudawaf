resource "azurerm_resource_group" "resource_group" {
  name     = "${var.name}"
  location = "${var.location}"
}

data "azurerm_subnet" "subnet" {
  name                 = "shared"
  virtual_network_name = "subscription-vnet-northeurope"
  resource_group_name  = "subscription-vnet-northeurope"
}

resource "azurerm_network_interface" "network_interface" {
  name                = "${var.name}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"

  ip_configuration {
    name                          = "configuration"
    subnet_id                     = "${data.azurerm_subnet.subnet.id}"
    private_ip_address_allocation = "Static"
    private_ip_address            = "172.29.97.7"
  }
}

resource "azurerm_virtual_machine" "virtual_machine" {
  name                             = "${var.name}"
  location                         = "${var.location}"
  resource_group_name              = "${azurerm_resource_group.resource_group.name}"
  network_interface_ids            = ["${azurerm_network_interface.network_interface.id}"]
  vm_size                          = "Standard_DS1_v2"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "barracudanetworks"
    offer     = "waf"
    sku       = "hourly"
    version   = "latest"
  }

  plan {
    name      = "hourly"
    publisher = "barracudanetworks"
    product   = "waf"
  }

  storage_os_disk {
    name              = "${var.name}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = "${var.name}"
    admin_username = "azureuser"
    admin_password = "${var.admin_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

output "ip" {
  value = "${azurerm_network_interface.network_interface.private_ip_address}"
}

resource "null_resource" "license" {
  provisioner "local-exec" {
    command = "powershell.exe -executionpolicy bypass -noprofile -file ${path.cwd}\\license.ps1 ${azurerm_network_interface.network_interface.private_ip_address}"
  }

  depends_on = ["azurerm_virtual_machine.virtual_machine"]
}
