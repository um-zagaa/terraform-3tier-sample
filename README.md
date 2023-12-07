# terraform-3tier-sample
Terraform 3 tier sample

## Create secret variables file that not registerd on git
Create `secrets.tfvars` file

Add sensitive variable and values like below
```
# Your trusted external IP for SSH access 
ssh-locate  = "xx.xx.xx.xx/32" # Your SSH connection IP

# Your database user for production 
db-user     = "************" # your DB user

# Your database password for production 
db-password = "************" # your DB password
```

## Terraform initialize (first time only)
Initialize terraform for run  
```
terraform init
```

## Format files
Format style for your terraform files
```
terraform fmt
```

## Terraform plan from source
Planing infra structure for change  
Execute before apply  
```
terraform plan -var-file="secrets.tfvars"
```

## Terraform validate source
Check terraform file errors
```
terraform validate
```

## Terraform execute plan to cloud with secret values
Execute infra structure for production (Create / Change)
```
terraform apply -var-file="secrets.tfvars"
```

## Terraform destroy all resource created by terraform
Remove infra structure for production
```
terraform destroy -var-file="secrets.tfvars"
```
