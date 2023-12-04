# terraform-3tier-sample
Terraform 3 tier sample

## Terraform initialize (first time only)
`terraform init`

## Format files
`terraform fmt`

## Terraform plan from source
`terraform plan -var-file="secrets.tfvars"`

## Terraform validate source
`terraform validate`

## Terraform execute plan to cloud with secret values
`terraform apply -var-file="secrets.tfvars"`

## Terraform destroy all resource created by terraform
`terraform destroy -var-file="secrets.tfvars"`
