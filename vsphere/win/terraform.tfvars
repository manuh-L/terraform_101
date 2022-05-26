#vcenter
vsphere_server = "vcenter name or ip"
datacenter = "Maputo"
cluster= "DEV"
datastore= "Bronze"
net_name = "Servers Dev"
template= "Win2k16_updated"
vm_name = "Test_Terra" 
workgroup = "Hashicorp"

#Resources
num_cpus = "2"
memory   = "4096"

#network
ipv4_address = "192.168.133.20"
ipv4_netmask = "27"
dns_server_list = ["192.168.10.1"]
ipv4_gateway = "192.168.133.30"