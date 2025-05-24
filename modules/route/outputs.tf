output "primary_dns_record" {
  description = "Primary failover DNS record"
  value       = aws_route53_record.failover_primary.fqdn
}

output "secondary_dns_record" {
  description = "Secondary failover DNS record"
  value       = aws_route53_record.failover_secondary.fqdn
}
