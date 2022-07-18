/* Configure Network Interfaces and public ip for the virtual machine */
# Create public IP
resource "azurerm_public_ip" "mediawikipublicip" {
  name = "myPublicIP"
  location = "${var.location}"
  resource_group_name = "${azurerm_resource_group.mediawikigroup.name}"
  allocation_method       = "Static"

  tags = {
    group = "mediawiki Demo"
  }
}
# Associating Subnet with Security Group
resource "azurerm_subnet_network_security_group_association" "publicnetworkassocciation" {
  subnet_id                 = "${azurerm_subnet.mypublicsubnet.id}"
  network_security_group_id = "${azurerm_network_security_group.mediawikinsg.id}"
}

resource "azurerm_subnet_network_security_group_association" "privatenetworkassocciation" {
  subnet_id                 = "${azurerm_subnet.myprivatesubnet.id}"
  network_security_group_id = "${azurerm_network_security_group.mediawikinsg.id}"
}


# Create network interface
resource "azurerm_network_interface" "mediawikipublicnic" {
  name       = "myPublicNIC"
  location       = "${var.location}"
  resource_group_name = "${azurerm_resource_group.mediawikigroup.name}"

  ip_configuration {
    name = "myPublicNicConfiguration"
    subnet_id = "${azurerm_subnet.mypublicsubnet.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id= "${azurerm_public_ip.mediawikipublicip.id}"
  }
  tags = {
    group = "mediawiki Demo"
  }
}

resource "azurerm_network_interface" "mediawikiprivatenic" {
  name = "myRundeckNIC"
  location = "${var.location}"
  resource_group_name = "${azurerm_resource_group.mediawikigroup.name}"

  ip_configuration {
    name = "mymediawikiNICConfiguration"
    subnet_id = "${azurerm_subnet.myprivatesubnet.id}"
    private_ip_address_allocation = "static"
    private_ip_address = "10.0.1.4"
  }
  tags = {
    group = "mediawiki Demo"
  }
}