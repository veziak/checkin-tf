# core
variable "region" {
  description = "The AWS region to create resources in."
  default     = "eu-west-2"
}

variable "aws_account_id" {
  description = "AWS Account id"
}

# networking

variable "public_subnet_1_cidr" {
  description = "CIDR Block for Public Subnet 1"
  default     = "10.0.1.0/24"
}
variable "public_subnet_2_cidr" {
  description = "CIDR Block for Public Subnet 2"
  default     = "10.0.2.0/24"
}
variable "private_subnet_1_cidr" {
  description = "CIDR Block for Private Subnet 1"
  default     = "10.0.3.0/24"
}
variable "private_subnet_2_cidr" {
  description = "CIDR Block for Private Subnet 2"
  default     = "10.0.4.0/24"
}
variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-west-1a", "us-west-1b"]
}

# load balancer
variable "health_check_path" {
  description = "Health check path for the default target group"
  default     = "/"
}

# ecs
variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
}

variable "ecs_cpu" {
  default = 512
}

variable "ecs_memory" {
  default = 1024
}

variable "autoscaling_max_capacity" {
  default = 4
}

variable "autoscaling_min_capacity" {
  default = 1
}

variable "frontend_image_url" {
  description = "Docker image to run frontend app in the ECS cluster"
}

variable "backend_image_url" {
  description = "Docker image to run backend app in the ECS cluster"
}

# logs
variable "log_retention_in_days" {
  default = 7
}

# domain
variable "domain_name" {
  description = "Domain name"
}

variable "route53_zone" {
  description = "Route53 zone name"
}