variable "zone_id" {
  description = "Route 53 Hosted Zone ID"
  type        = string
}

variable "record_name" {
  description = "DNS record name to create (e.g., app.example.com)"
  type        = string
}

variable "primary_ip" {
  description = "ip of the primary instance used for health check"
  type        = string
}

variable "secondary_ip" {
  description = "ip of the secondary instance used for health check"
  type        = string
}

variable "primary_ip" {
  description = "IP address of the primary EC2 instance"
  type        = string
}

variable "secondary_ip" {
  description = "IP address of the secondary EC2 instance"
  type        = string
}
