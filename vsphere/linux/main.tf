

##################################################################################
# PROVIDER
##################################################################################
provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

 
  allow_unverified_ssl = true
}

##################################################################################
# DATA
##################################################################################

data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}


data "vsphere_network" "network" {
  name          = var.net_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.template
  datacenter_id = data.vsphere_datacenter.dc.id
}


##################################################################################
# RESOURCES
##################################################################################

resource "vsphere_virtual_machine" "vm" {
  count = var.vm_number
  name             = "${var.vm_name}-${count.index + 1}"
  datastore_id     = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id

  num_cpus = var.num_cpus
  memory   = var.memory
  guest_id = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type
  folder = var.folder_path



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

#      windows_options {
#        computer_name = var.vm_name
#        workgroup    = var.workgroup
#        admin_password = var.vm_password
#      }

      linux_options {
        host_name = "${var.hostname}-${count.index + 1}"
        domain    = var.domain
      }

      network_interface {
        ipv4_address = "192.168.100.${count.index + 41}" #var.ipv4_address
        ipv4_netmask = var.ipv4_netmask
        dns_server_list = var.dns_server_list
      }
      
      ipv4_gateway = var.ipv4_gateway
      dns_server_list = var.dns_server_list
      dns_suffix_list = [var.domain]
      
    }
  }

   connection {
    type     = "ssh"
    user     = "root"
    password = var.vm_password
    host     = self.default_ip_address #vsphere_virtual_machine.vm[count.index].default_ip_address
 }

  provisioner "remote-exec" {
   inline = [
      "sudo yum update -y && yum install httpd -y"
      
    ]
 }

#   provisioner "local-exec" {
#    command = "ansible-playbook hostname.yml -i ${vsphere_virtual_machine.vm.default_ip_address}, -u root "
#  }

}

#output "name" {
#value = vsphere_virtual_machine.vm.name

#}
#output "ip" {
#value = vsphere_virtual_machine.vm.default_ip_address

#}