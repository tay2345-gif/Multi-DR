variable "zone_id" {
  description = "Route 53 hosted zone ID"
  type        = string
}

variable "record_name" {
  description = "Record name to create (e.g., app.example.com)"
  type        = string
}

variable "primary_ip" {
  description = "Primary region's public IP"
  type        = string
}

variable "secondary_ip" {
  description = "Secondary region's public IP"
  type        = string
}
