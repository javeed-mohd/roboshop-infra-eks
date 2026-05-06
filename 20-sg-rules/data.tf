# Data sources are used to query and fetch existing information from your provider like AWS, so you can use that data in your Terraform configuration.
# AMI-ID data source
data "http" "my_public_ip_v4" {
  url = "https://ipv4.icanhazip.com"
}

output "my_ipv4_address" {
  value = chomp(data.http.my_public_ip_v4.response_body)
}

# BASTION SG Id data source
# A bastion host is a special server that acts as a secure gateway to access resources inside a private network (like private VMs or instances)
data "aws_ssm_parameter" "bastion_sg_id" {
    name = "/${var.project}/${var.environment}/bastion_sg_id"       # /roboshop/dev/bastion_sg_id
}

# MONGODB SG Id data source
data "aws_ssm_parameter" "mongodb_sg_id" {
    name = "/${var.project}/${var.environment}/mongodb_sg_id"       # /roboshop/dev/mongodb_sg_id
}

# REDIS SG Id data source
data "aws_ssm_parameter" "redis_sg_id" {
    name = "/${var.project}/${var.environment}/redis_sg_id"         # /roboshop/dev/redis_sg_id
}

# MySQL SG Id data source
data "aws_ssm_parameter" "mysql_sg_id" {
    name = "/${var.project}/${var.environment}/mysql_sg_id"         # /roboshop/dev/mysql_sg_id
}

# RABBITMQ SG Id data source
data "aws_ssm_parameter" "rabbitmq_sg_id" {
    name = "/${var.project}/${var.environment}/rabbitmq_sg_id"      # /roboshop/dev/rabbitmq_sg_id
}

# Ingress ALB SG Id data source
data "aws_ssm_parameter" "ingress_alb_sg_id" {
    name = "/${var.project}/${var.environment}/ingress_alb_sg_id"            # /roboshop/dev/ingress_alb_sg_id
}

# EKS Control Plane SG Id data source
data "aws_ssm_parameter" "eks_control_plane_sg_id" {
    name = "/${var.project}/${var.environment}/eks_control_plane_sg_id"      # /roboshop/dev/eks_control_plane_sg_id
}

# EKS Node SG Id data source
data "aws_ssm_parameter" "eks_node_sg_id" {
    name = "/${var.project}/${var.environment}/eks_node_sg_id"               # /roboshop/dev/eks_node_sg_id
}

# Openvpn SG Id data source
data "aws_ssm_parameter" "openvpn_sg_id" {
    name = "/${var.project}/${var.environment}/openvpn_sg_id"                # /roboshop/dev/openvpn_sg_id
}

# Jenkins SG Id data source
data "aws_ssm_parameter" "jenkins_sg_id" {
    name = "/${var.project}/${var.environment}/jenkins_sg_id"               # /roboshop/dev/jenkins_sg_id
}

# Jenkins Agent SG Id data source
data "aws_ssm_parameter" "jenkins_agent_sg_id" {
    name = "/${var.project}/${var.environment}/jenkins_agent_sg_id"         # /roboshop/dev/jenkins_agent_sg_id
}

# Sonar SG Id data source
data "aws_ssm_parameter" "sonar_sg_id" {
    name = "/${var.project}/${var.environment}/sonar_sg_id"                 # /roboshop/dev/sonar_sg_id
}