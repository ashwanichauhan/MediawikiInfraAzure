/* Configure Azure Provider and declare all the Variables that will be used in Terraform configurations */
provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id = "${var.client_id}"
  client_secret = "${var.client_secret}"
  tenant_id = "${var.tenant_id}"
  features {}
}
variable "subscription_id" {
  description = "Enter Subscription ID for provisioning resources in Azure"
}
variable "client_id" {
  description = "Enter Client ID for Application created in Azure AD"
}
variable "client_secret" {
  description = "Enter Client secret for Application in Azure AD"
}
variable "tenant_id" {
  description = "Enter Tenant ID of your Azure AD"
}
variable "location" {
  description = "The region for the resource provisioning"
}
variable "resource_group_name" {
  description = "Resource group name that will contain various resources"
}
variable "myVNetCIDR" {
  description = "CIDR block for Virtual Network"
}
variable "myPrivateCIDR" {
  description = "Private CIDR block for Subnet within a Virtual Network"
}
variable "myPublicCIDR" {
  description = "Public CIDR block for Subnet within a Virtual Network"
}

variable "myVirtualNetwork" {
  description = "Enter Virtual Network name"
}
variable "myPrivateSubnet" {
  description = "Enter Private Subnet name"  
}
variable "myPublicSubnet" {
  description = "Enter Public Subnet name"  
}

variable "myMediawikiUsername" {
  description = "Enter Rundeck UserName"  
}

variable "myVPNUsername" {
  description = "Enter Vpn UserName"  
}
variable "myVMPassword" {
  description = "Enter Password"  
}

variable "application_port"{
description = "Enter port" 
}