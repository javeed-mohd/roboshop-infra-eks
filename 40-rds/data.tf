# Database Subnet Group Name data source
data "aws_ssm_parameter" "database_subnet_group_name" {
    name = "/${var.project}/${var.environment}/database_subnet_group_name"       # /roboshop/dev/database_subnet_group_name
}

# MySQL SG Id data source
data "aws_ssm_parameter" "mysql_sg_id" {
    name = "/${var.project}/${var.environment}/mysql_sg_id"       # /roboshop/dev/mysql_sg_id
}