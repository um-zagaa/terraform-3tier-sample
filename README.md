# Terraform-3tier-sample project
Create 3 tier sample infra on AWS with Terraform  

## Infra structure
You infra structure will created as below.  
You can change with your own infra structure configuration.  
![Infra structure image](<images/3 Tier Diagram-Infra.drawio.png>)


## Infra security
You infra security will created as below.  
You can change with your own security configuruation.  
![Infra security image](<images/3 Tier Diagram-Communication and security.drawio.png>)

# How to use
You will need to install terraform on you local computer.  
And setup AWS access key (You can use AWS CLI or just create your own).  

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
