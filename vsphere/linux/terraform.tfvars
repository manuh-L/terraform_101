##################################################################################
# VARIABLES INPUT
##################################################################################
#vcenter
vsphere_server = "vcsa-01.lab.com"
datacenter = "MGlobal"
cluster= "Tanzu-Cluster"
datastore= "Local-DS01"
net_name = "VM-Network"
template= "CentOS-Stream-22"
vm_name = "hello-world" 
workgroup = "Hashicorp"
hostname= "demo"
vm_number= "1"

#Resources
num_cpus = "2"
memory   = "4096"

#network
ipv4_address = ""
ipv4_netmask = "24"
dns_server_list = ["192.168.100.203"]
ipv4_gateway = "192.168.100.1"