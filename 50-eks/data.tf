# Data sources are used to query and fetch existing information from your provider like AWS, so you can use that data in your Terraform configuration.
# VPC-ID data source
data "aws_ssm_parameter" "vpc_id" {
    name = "/${var.project}/${var.environment}/vpc_id"                     # /roboshop/dev/vpc_id
}

# Private Subnet Id data source
data "aws_ssm_parameter" "private_subnet_ids" {
    name = "/${var.project}/${var.environment}/private_subnet_ids"          # /roboshop/dev/private_subnet_ids
}

# EKS Control Plane SG Id data source
data "aws_ssm_parameter" "eks_control_plane_sg_id" {
    name = "/${var.project}/${var.environment}/eks_control_plane_sg_id"      # /roboshop/dev/eks_control_plane_sg_id
}

# EKS Node SG Id data source
data "aws_ssm_parameter" "eks_node_sg_id" {
    name = "/${var.project}/${var.environment}/eks_node_sg_id"               # /roboshop/dev/eks_node_sg_id
}