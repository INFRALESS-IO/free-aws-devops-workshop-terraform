# output "public_subnet_ids" {
#   description = "The IDs of the public subnets"
#   value       = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
# }

# Output for AWS Load Balancer Endpoint
# output "lb_endpoint" {
#   description = "The DNS name of the Load Balancer."
#   value       = module.alb.dns_name
# }

output "route53_domain" {
  description = "The Application Domain Name"
  value       = aws_route53_record.main.name
}

# Output for Aurora MySQL Database Endpoint
# output "db_endpoint" {
#   description = "The endpoint of the Aurora MySQL Database."
#   value       = aws_rds_cluster.aurora_cluster.endpoint
# }

# # Output for EC2 Bastion Host Public IP
# output "bastion_public_ip" {
#   description = "The public IP address of the Bastion Host."
#   # Assuming a bastion host resource was defined as aws_instance.bastion
#   value       = aws_instance.bastion.public_ip
# }
