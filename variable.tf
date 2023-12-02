## VPC CIDR Block
variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "VPC_cidr block"
  type        = string
}

## Presentation Tier CIDR Block 1
variable "public-web-subnet-1-cidr" {
  default     = "10.0.1.0/24"
  description = "public_web_subnet1"
  type        = string
}

## Presentation Tier CIDR Block 2
variable "public-web-subnet-2-cidr" {
  default     = "10.0.2.0/24"
  description = "public_web_subnet2"
  type        = string
}

## App Tier CIDR Block 1
variable "private-app-subnet-1-cidr" {
  default     = "10.0.3.0/24"
  description = "private_app_subnet1"
  type        = string
}

## App Tier CIDR Block 2
variable "private-app-subnet-2-cidr" {
  default     = "10.0.4.0/24"
  description = "private_app_subnet2"
  type        = string
}

## DB Tier CIDR Block 1
variable "private-db-subnet-1-cidr" {
  default     = "10.0.5.0/24"
  description = "private_db_subnet1"
  type        = string
}

## DB Tier CIDR Block 2
variable "private-db-subnet-2-cidr" {
  default     = "10.0.6.0/24"
  description = "private_db_subnet2"
  type        = string
}

## DB instance
variable "database-instance-class" {
  default     = "db.t2.micro"
  description = "The database instance type"
  type        = string
}

## multi AZ deployment
variable "multi-az-deployment" {
  default     = true
  description = "Create a Standby DB Instance"
  type        = bool
}

## Bastion host connect IP address
variable "ssh-locate" {
  description = "SSH access ip address"
  type        = string
  sensitive   = true
}

## DB schema
variable "db-schema" {
  default     = "sampleapp3tier"
  description = "The database schema name"
  type        = string
}

## DB user
variable "db-user" {
  description = "The database user"
  type        = string
  sensitive   = true
}

## DB password
variable "db-password" {
  description = "The database password"
  type        = string
  sensitive   = true
}

## sensitive variable setting guide
## Create "secrets.tfvars" -> this file not added to git
## add sensitive variable and values like below
# ssh-locate  = "xx.xx.xx.xx/32" # Your SSH connection IP
# db-user     = "************" # your DB user
# db-password = "************" # your DB password
