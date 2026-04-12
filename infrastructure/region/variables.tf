variable "region" {
  description = "Region of AWS for staging infrastructure"
  type        = string
}

variable "network_cidr" {
  description = "Network CIDR for VPC"
  type        = string
}

variable "ecs_policy" {
  description = "The name attribute of the IAM instance profile"
  type        = string
}

variable "enable_nat_gateway" {
  description = "Create NAT gateways and route private subnets through them. Set to false when all services use public_task = true."
  type        = bool
  default     = true
}
