##################################################################################
# VARIABLES
##################################################################################
variable "vsphere_user" {}
variable "vsphere_password" {
    sensitive = "true"
}
variable "vsphere_server" {}
variable "vm_password" {
    sensitive = "true"
}
variable "datacenter" {}
variable "cluster" {}
variable "datastore" {}
variable "net_name" {}
variable "template" {}
variable "vm_name" {}
variable "workgroup" {}
variable "num_cpus" {}
variable "memory" {}
variable "ipv4_address" {}
variable "ipv4_netmask" {}
variable "dns_server_list" {}
variable "ipv4_gateway" {}
variable "hostname" {}
variable "domain" {
    default = "lab.com"
}
