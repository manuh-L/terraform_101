#Terraform + vSphere
terraform plan -var-file="secret.tfvars"

terraform apply -var-file="secret.tfvars" -auto-approve 