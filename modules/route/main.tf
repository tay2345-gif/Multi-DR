resource "aws_route53_record" "primary" {
  zone_id = var.zone_id
  name    = var.record_name
  type    = "A"
  ttl     = 300
  records = [var.primary_ip]
}

resource "aws_route53_record" "secondary" {
  zone_id = var.zone_id
  name    = "failover.${var.record_name}"
  type    = "A"
  ttl     = 300
  records = [var.secondary_ip]
}

