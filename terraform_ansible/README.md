#HOW TO RUN
terraform init

terraform plan -var-file="keys.tfvars"

terraform apply -var-file="keys.tfvars" -auto-approve

###Delete
terraform destroy -auto-approve