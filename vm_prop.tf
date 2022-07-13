/* Configure all the Virtual Machines that will be created using Terraform */
#Creating VPN VM in Public Subnet
resource "azurerm_virtual_machine" "mediawikipublicvm" {
  name                  = "VPNVM"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.mediawikigroup.name}"
  network_interface_ids = ["${azurerm_network_interface.mediawikipublicnic.id}"]
  vm_size               = "Standard_DS1_v2"

#This will delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name          = "mypublicOSDisk"
    vhd_uri       = "${azurerm_storage_account.mystorageaccount.primary_blob_endpoint}${azurerm_storage_container.mycontainer.name}/mypublicOSDisk.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "VPNVM"
    admin_username = "${var.myVPNUsername}"
    admin_password = "${var.myVMPassword}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }


  provisioner "remote-exec" {
    command = "command to playbook on vmss (playbook.yaml)"
  }

  tags = {
    group = "Mediawiki Demo"
    Name = "VPN"
    Tools-installed = "VPN"
  }
}



/* resource "azurerm_virtual_machine" "mediawikivm" {
  name                  = "MediawikiVM"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.mediawikigroup.name}"
  network_interface_ids = ["${azurerm_network_interface.mediawikinic.id}"]
  vm_size               = "Standard_DS1_v2"

#This will delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "7.6"
    version   = "latest"
  }

  storage_os_disk {
    name          = "mymediawikiOSDisk"
    vhd_uri       = "${azurerm_storage_account.mystorageaccount.primary_blob_endpoint}${azurerm_storage_container.mycontainer.name}/mymediawikiOSDisk.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "MediawikiVM"
    admin_username = "${var.myMediawikiUsername}"
    admin_password = "${var.myVMPassword}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    group = "Terraform Demo"
    Name = "MediawikiVM"
    PrivateIP = "10.0.1.4"
  }
} */