resource "aws_route53_health_check" "primary" {
  fqdn              = var.primary_ip
  type              = "HTTP"
  port              = 80
  resource_path     = "/"
  failure_threshold = 3
  request_interval  = 30
}

resource "aws_route53_health_check" "secondary" {
  fqdn              = var.secondary_ip
  type              = "HTTP"
  port              = 80
  resource_path     = "/"
  failure_threshold = 3
  request_interval  = 30
}

resource "aws_route53_record" "failover_primary" {
  zone_id        = var.zone_id
  name           = var.record_name
  type           = "A"
  set_identifier = "primary"
  failover       = "PRIMARY"
  ttl            = 60
  records        = [var.primary_ip]

  health_check_id = aws_route53_health_check.primary.id
}

resource "aws_route53_record" "failover_secondary" {
  zone_id        = var.zone_id
  name           = var.record_name
  type           = "A"
  set_identifier = "secondary"
  failover       = "SECONDARY"
  ttl            = 60
  records        = [var.secondary_ip]

  health_check_id = aws_route53_health_check.secondary.id
}
