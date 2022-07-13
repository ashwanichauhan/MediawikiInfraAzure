/* Configure virtual machine extensions for all the VMs that are created using Terraform*/
#Custom script for VPN VM 
resource "azurerm_virtual_machine_extension" "cs_vpn" {
  name = "custom_vpn"
  virtual_machine_id    = "${azurerm_virtual_machine.mediawikipublicvm.id}"
  publisher = "Microsoft.Azure.Extensions"
  type = "CustomScript"
  type_handler_version  = "2.0"

#Link for the bash script which is stored in Azure Storage account
  settings = <<SETTINGS
  {
"fileUris": [
"(blob url))" 
],
"commandToExecute": "sh installopenvpn.sh"
  }
SETTINGS

  tags = {
    group = "Terraform Demo"
    Name = "VPN"
    Tools-installed = "VPN"
  }
}
