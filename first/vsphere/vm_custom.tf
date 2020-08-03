variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}
variable "vm_password" {}

provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "Moza Banco"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "Disaster Recovery Site"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name          = "Pool3-DataStore12-VNXR5"
  datacenter_id = data.vsphere_datacenter.dc.id
}


data "vsphere_network" "network" {
  name          = "VLAN 850 - Servers Dev"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = "Win2k16_pvscsi_winrm"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = "SVDRSTEST"
  datastore_id     = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id

  num_cpus = 2
  memory   = 4096
  guest_id = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type
  
  network_interface {
    network_id = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label = "disk0"
    size  = data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {

      windows_options {
        computer_name = "VM-test"
        workgroup    = "hashicorp"
        admin_password = var.vm_password
      }

      network_interface {
        ipv4_address = "10.111.133.11"
        ipv4_netmask = 27
        dns_server_list = ["10.111.1.97"]
      }
      
      ipv4_gateway = "10.111.133.30"
      
    }
  }

  
}