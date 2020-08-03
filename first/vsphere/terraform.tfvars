

vsphere_server = "svdrsvcp01"
datacenter = "Moza Banco"
cluster= "Disaster Recovery Site"
datastore= "Pool3-DataStore12-VNXR5"
net_name = "VLAN 850 - Servers Dev"
template= "Win2k16_pvscsi_winrm"
vm_name = "SVDRSTEST" 
workgroup = "Hashicorp"

#Resources
num_cpus = "2"
memory   = "4096"


ipv4_address = "10.111.133.11"
ipv4_netmask = "27"
dns_server_list = ["10.111.1.97"]
ipv4_gateway = "10.111.133.30"