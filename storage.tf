/* Configure azure storage account  */
# Generate random text for a unique storage account name
resource "random_id" "randomId" {
    keepers = {
        resource_group = "${azurerm_resource_group.mediawikigroup.name}"
    }
    
    byte_length = 8
}
# Create storage account for boot diagnostics
resource "azurerm_storage_account" "mystorageaccount" {
  name = "diag${random_id.randomId.hex}"
  resource_group_name = "${azurerm_resource_group.mediawikigroup.name}"
  location = "${var.location}"
  account_tier = "Standard"
  account_replication_type = "LRS"

tags = {
    group = "Terraform Demo"
  }
}
#Create a container in storage account
resource "azurerm_storage_container" "mycontainer" {
  name = "vhds"
  storage_account_name = "${azurerm_storage_account.mystorageaccount.name}"
  container_access_type = "private"
}