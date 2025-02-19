# Configure le fournisseur Azure
provider "azurerm" {
  features {}
  subscription_id = "55e7375a-949e-4d61-8ec0-064fe6bad2ab"
}

# Crée un groupe de ressources pour Resismart
resource "azurerm_resource_group" "resismart_rg" {
  name     = "resismart-resource-group"
  location = "francecentral"
}

# Crée un réseau virtuel pour Resismart
resource "azurerm_virtual_network" "resismart_vnet" {
  name                = "resismart-virtual-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.resismart_rg.location
  resource_group_name = azurerm_resource_group.resismart_rg.name
}

# Crée un sous-réseau pour Resismart
resource "azurerm_subnet" "resismart_subnet" {
  name                 = "resismart-subnet"
  resource_group_name  = azurerm_resource_group.resismart_rg.name
  virtual_network_name = azurerm_virtual_network.resismart_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Crée une IP publique pour la VM Master de Resismart
resource "azurerm_public_ip" "resismart_master_public_ip" {
  name                = "resismart-master-public-ip"
  location            = azurerm_resource_group.resismart_rg.location
  resource_group_name = azurerm_resource_group.resismart_rg.name
  allocation_method   = "Static"
}

# Crée une interface réseau pour la VM Master de Resismart
resource "azurerm_network_interface" "resismart_master_nic" {
  name                = "resismart-master-network-interface"
  location            = azurerm_resource_group.resismart_rg.location
  resource_group_name = azurerm_resource_group.resismart_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.resismart_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.resismart_master_public_ip.id
  }
}

# Crée la VM Master pour Resismart
resource "azurerm_linux_virtual_machine" "resismart_master_vm" {
  name                = "resismart-master-vm"
  resource_group_name = azurerm_resource_group.resismart_rg.name
  location            = azurerm_resource_group.resismart_rg.location
  size                = "Standard_B2s"
  admin_username      = "adminuser"

  network_interface_ids = [
    azurerm_network_interface.resismart_master_nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

# Crée une IP publique pour la VM Worker 1 de Resismart
resource "azurerm_public_ip" "resismart_worker1_public_ip" {
  name                = "resismart-worker1-public-ip"
  location            = azurerm_resource_group.resismart_rg.location
  resource_group_name = azurerm_resource_group.resismart_rg.name
  allocation_method   = "Static"
}

# Crée une interface réseau pour la VM Worker 1 de Resismart
resource "azurerm_network_interface" "resismart_worker1_nic" {
  name                = "resismart-worker1-network-interface"
  location            = azurerm_resource_group.resismart_rg.location
  resource_group_name = azurerm_resource_group.resismart_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.resismart_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.resismart_worker1_public_ip.id
  }
}

# Crée la VM Worker 1 pour Resismart
resource "azurerm_linux_virtual_machine" "resismart_worker1_vm" {
  name                = "resismart-worker1-vm"
  resource_group_name = azurerm_resource_group.resismart_rg.name
  location            = azurerm_resource_group.resismart_rg.location
  size                = "Standard_D2s_v3"
  admin_username      = "adminuser"

  network_interface_ids = [
    azurerm_network_interface.resismart_worker1_nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

# Crée une IP publique pour la VM Worker 2 de Resismart
resource "azurerm_public_ip" "resismart_worker2_public_ip" {
  name                = "resismart-worker2-public-ip"
  location            = azurerm_resource_group.resismart_rg.location
  resource_group_name = azurerm_resource_group.resismart_rg.name
  allocation_method   = "Static"
}

# Crée une interface réseau pour la VM Worker 2 de Resismart
resource "azurerm_network_interface" "resismart_worker2_nic" {
  name                = "resismart-worker2-network-interface"
  location            = azurerm_resource_group.resismart_rg.location
  resource_group_name = azurerm_resource_group.resismart_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.resismart_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.resismart_worker2_public_ip.id
  }
}

# Crée la VM Worker 2 pour Resismart
resource "azurerm_linux_virtual_machine" "resismart_worker2_vm" {
  name                = "resismart-worker2-vm"
  resource_group_name = azurerm_resource_group.resismart_rg.name
  location            = azurerm_resource_group.resismart_rg.location
  size                = "Standard_D2s_v3"
  admin_username      = "adminuser"

  network_interface_ids = [
    azurerm_network_interface.resismart_worker2_nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}
