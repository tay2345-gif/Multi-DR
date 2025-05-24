variable "name_prefix" {}

variable "db_engine" {
  default = "mysql"
}

variable "engine_version" {
  default = "8.0"
}

variable "db_name" {
  default = "mydatabase"
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  default = "Password123!"  # For demo; use secrets in real projects
  sensitive = true
}

variable "instance_class" {
  default = "db.t3.micro"
}

variable "storage" {
  default = 20
}

variable "storage_type" {
  default = "gp2"
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_security_ids" {
  type = list(string)
}

variable "multi_az" {
  type    = bool
  default = false
}
