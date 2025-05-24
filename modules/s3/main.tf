resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  force_destroy = true
  tags = {
    Name = var.bucket_name
    Environment = var.env
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Replication IAM Role (only if replication is enabled)
resource "aws_iam_role" "replication_role" {
  count = var.enable_replication ? 1 : 0

  name = "${var.bucket_name}-replication-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "s3.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "replication_policy" {
  count = var.enable_replication ? 1 : 0

  name = "${var.bucket_name}-replication-policy"
  role = aws_iam_role.replication_role[0].name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObjectVersionForReplication",
          "s3:GetObjectVersionAcl",
          "s3:GetObjectVersionTagging"
        ]
        Resource = "${aws_s3_bucket.this.arn}/*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:ReplicateObject",
          "s3:ReplicateDelete",
          "s3:ReplicateTags"
        ]
        Resource = "${var.replica_bucket_arn}/*"
      }
    ]
  })
}
