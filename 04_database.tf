# # Aurora MySQL Database in the secure subnet
# resource "aws_rds_cluster" "aurora_cluster" {
#   cluster_identifier   = "${var.project_name}-${var.environment}-aurora-cluster"
#   engine               = "aurora-mysql"
#   engine_version       = "5.7.mysql_aurora.2.07.1"
#   database_name        = "mydb"
#   master_username      = "dbadmin"
#   master_password      = "yourpassword" # It's recommended to use a secrets manager
#   backup_retention_period = 5
#   preferred_backup_window = "07:00-09:00"
#   vpc_security_group_ids = [aws_security_group.aurora_sg.id]
#   db_subnet_group_name = aws_db_subnet_group.aurora_sg.name
# }
