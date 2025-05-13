terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.26.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rajan"
    storage_account_name = "pipelinestorageaccoun4"
    container_name       = "pipelinecontainer"
    key                  = "git.tfstate"
  }
}
provider "azurerm" {
  features {}
  subscription_id = "0cead613-b99d-4057-9b73-e282208bb4c4"
}

resource "azurerm_resource_group" "name" {
  name     = "github-rg"
  location = "East US"
}
resource "azurerm_virtual_network" "vnet" {
  name                = "github-vnet"
  location            = "East US"
  resource_group_name = azurerm_resource_group.name.name
  address_space       = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "sbnet" {
  name                 = "github-subnet"
  resource_group_name  = azurerm_resource_group.name.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_network_interface" "nic" {
  name                = "github-nic"
  location            = "East US"
  resource_group_name = azurerm_resource_group.name.name
  ip_configuration {
    name                          = "github-ipconfig"
    subnet_id                     = azurerm_subnet.sbnet.id
    private_ip_address_allocation = "Dynamic"
  }
}