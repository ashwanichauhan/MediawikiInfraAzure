/* Configure Network Security Group and all the rules that will be used in Terraform configurations */
resource "azurerm_network_security_group" "mediawikinsg" {
  name = "myNetworkSecurityGroup"
  location = "${var.location}"
  resource_group_name = "${azurerm_resource_group.mediawikigroup.name}"

security_rule{
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"

    }
    security_rule{
        name                       = "OpenVPN443"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
    security_rule{
        name                       = "OpenVPN1194"
        priority                   = 1003
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "UDP"
        source_port_range          = "*"
        destination_port_range     = "1194"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
    security_rule{
        name                       = "allow-internet"
        priority                   = 1004
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
    
    security_rule{
        name                       = "allow-mediawikiport"
        priority                   = 1006
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "4440"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
   
    
    

  tags = {
        group = "Terraform Demo"
  }
}