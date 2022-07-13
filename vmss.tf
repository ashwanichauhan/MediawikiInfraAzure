resource "azurerm_public_ip" "vmss" {
 name                         = "vmss-public-ip"
 location                     = "${var.location}"
 resource_group_name          = azurerm_resource_group.vmss.name
 allocation_method            = "Static"
 domain_name_label            = random_string.fqdn.result
 
}

resource "azurerm_lb" "vmss" {
 name                = "vmss-lb"
 location            = "${var.location}"
 resource_group_name = "${azurerm_resource_group.mediawikigroup.name}"

 frontend_ip_configuration {
   name                 = "PublicIPAddress"
   public_ip_address_id = "${azurerm_public_ip.vmss.id}"
 }

 tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "bpepool" {
 loadbalancer_id     = azurerm_lb.vmss.id
 name                = "BackEndAddressPool"
}

resource "azurerm_lb_probe" "vmss" {
 resource_group_name = "${azurerm_resource_group.mediawikigroup.name}"
 loadbalancer_id     = azurerm_lb.vmss.id
 name                = "ssh-running-probe"
 port                = var.application_port
}

resource "azurerm_lb_rule" "lbnatrule" {
   resource_group_name            = "${azurerm_resource_group.mediawikigroup.name}"
   loadbalancer_id                = azurerm_lb.vmss.id
   name                           = "http"
   protocol                       = "Tcp"
   frontend_port                  = var.application_port
   backend_port                   = var.application_port
   backend_address_pool_id        = azurerm_lb_backend_address_pool.bpepool.id
   frontend_ip_configuration_name = "PublicIPAddress"
   probe_id                       = azurerm_lb_probe.vmss.id
}

resource "azurerm_virtual_machine_scale_set" "vmss" {
 name                = "vmscaleset"
 location            = "${var.location}"
 resource_group_name = "${azurerm_resource_group.mediawikigroup.name}"
 upgrade_policy_mode = "Manual"

 sku {
   name     = "Standard_DS1_v2"
   tier     = "Standard"
   capacity = 2
 }

 storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "7.6"
    version   = "latest"
  }


 storage_profile_os_disk {
   name              = "vmssos disk"
   caching           = "ReadWrite"
   create_option     = "FromImage"
   managed_disk_type = "Standard_LRS"
 }

 storage_profile_data_disk {
   lun          = 0
   caching        = "ReadWrite"
   create_option  = "Empty"
   disk_size_gb   = 10
 }

 os_profile {
   computer_name_prefix = "MediawikiVmss"
    admin_username = "${var.myMediawikiUsername}"
    admin_password = "${var.myVMPassword}"
   custom_data          = file("web.conf")
 }

 os_profile_linux_config {
   disable_password_authentication = false
 }

 network_profile {
   name    = "terraformnetworkprofile"
   primary = true

   ip_configuration {
     name                                   = "IPConfiguration"
     subnet_id                              = "${azurerm_subnet.myprivatesubnet.id}"
     load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool.id]
     primary = true
   }
 }

 tags = var.tags
}

