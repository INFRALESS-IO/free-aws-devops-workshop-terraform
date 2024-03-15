output "route53_domain" {
  description = "The Application Domain Name"
  value       = aws_route53_record.main.name
}

output "ecr_app1" {
  description = "The Application Domain Name"
  value       = aws_ecr_repository.app1.repository_url
}

