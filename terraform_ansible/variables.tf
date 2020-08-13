##################################################################################
# VARIABLES
##################################################################################

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "key_name" {}
variable "user" {
    description = "user for ssh"
}
variable "region" {
    default = "af-south-1"
}