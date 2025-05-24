variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}

variable "env" {
  type        = string
  description = "Environment (primary/secondary)"
}

variable "enable_replication" {
  type        = bool
  description = "Whether to enable replication to another region"
  default     = false
}

variable "replica_bucket_arn" {
  type        = string
  description = "ARN of the destination bucket for replication"
  default     = ""
}
