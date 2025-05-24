variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of public subnet CIDRs"
}

variable "azs" {
  type        = list(string)
  description = "Availability zones for subnets"
}

variable "env" {
  type        = string
  description = "Environment name (e.g., primary, secondary)"
}
