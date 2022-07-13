/* Configure resource group and the virtual network  */
# Create a resource group if it doesn’t exist
resource "azurerm_resource_group" "mediawikigroup" {
  name = "${var.resource_group_name}"
  location = "${var.location}"
}
# Create virtual network
resource "azurerm_virtual_network" "mediawikinetwork" {
  name = "${var.myVirtualNetwork}"
  address_space = ["${var.myVNetCIDR}"]
  location = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.mediawikigroup.name}"

  tags = {
  group = "mediawiki Demo"

  }
}
#Create Private Subnet
resource "azurerm_subnet" "myprivatesubnet" {
  name = "${var.myPrivateSubnet}"
  address_prefix = "${var.myPrivateCIDR}"
  virtual_network_name = "${azurerm_virtual_network.mediawikinetwork.name}"
  resource_group_name = "${azurerm_resource_group.mediawikigroup.name}"
}
#Create Public Subnet
resource "azurerm_subnet" "mediawikisubnet" {
  name = "${var.myPublicSubnet}"
  address_prefix = "${var.myPublicCIDR}"
  virtual_network_name = "${azurerm_virtual_network.mediawikinetwork.name}"
  resource_group_name = "${azurerm_resource_group.mediawikigroup.name}"
}
