resource "azurerm_resource_group" "resource_group" {
  name     = "${var.name}"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.name}"
  address_space       = ["10.0.0.0/28"]
  location            = "${azurerm_resource_group.resource_group.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.name}"
  resource_group_name  = "${azurerm_resource_group.resource_group.name}"
  virtual_network_name = "${azurerm_virtual_network.virtual_network.name}"
  address_prefix       = "10.0.0.0/28"
}

resource "azurerm_public_ip" "public_ip" {
  name                         = "${var.name}"
  location                     = "${azurerm_resource_group.resource_group.location}"
  resource_group_name          = "${azurerm_resource_group.resource_group.name}"
  domain_name_label            = "${var.name}"
  public_ip_address_allocation = "Dynamic"
  idle_timeout_in_minutes      = 30
}

resource "azurerm_network_interface" "network_interface" {
  name                = "${var.name}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"

  ip_configuration {
    name                          = "configuration"
    subnet_id                     = "${azurerm_subnet.subnet.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.public_ip.id}"
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

data "azurerm_public_ip" "public_ip" {
  name                = "${azurerm_public_ip.public_ip.name}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  depends_on          = ["azurerm_virtual_machine.virtual_machine"]
}

output "fqdn" {
  value = "${data.azurerm_public_ip.public_ip.fqdn}"
}

resource "null_resource" "license" {
  provisioner "local-exec" {
    command = "powershell.exe -executionpolicy bypass -noprofile -file ${path.cwd}\\license.ps1 ${data.azurerm_public_ip.public_ip.fqdn}"
  }
}
