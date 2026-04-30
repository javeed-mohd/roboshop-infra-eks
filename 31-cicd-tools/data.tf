# Data sources are used to query and fetch existing information from your provider like AWS, so you can use that data in your Terraform configuration.
# AMI-ID data source
data "aws_ami" "joindevops" {
  most_recent      = true
  owners           = ["973714476881"]

  filter {
    name   = "name"
    values = ["Redhat-9-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "sonarqube" {
  most_recent = true
  owners      = ["679593333241"] # Solve DevOps

  filter {
    name   = "name"
    values = ["SolveDevOps-SonarQube-Server-Ubuntu24.04-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Public Subnet Id data source
data "aws_ssm_parameter" "public_subnet_ids" {
    name = "/${var.project}/${var.environment}/public_subnet_ids"         # /roboshop/dev/public_subnet_ids
}

# Jenkins Security Group Id data source
data "aws_ssm_parameter" "jenkins_sg_id" {
    name = "/${var.project}/${var.environment}/jenkins_sg_id"             # /roboshop/dev/jenkins_sg_id
}

# Jenkins Agent Security Group Id data source
data "aws_ssm_parameter" "jenkins_agent_sg_id" {
    name = "/${var.project}/${var.environment}/jenkins_agent_sg_id"       # /roboshop/dev/jenkins_agent_sg_id
}

# Sonar Security Group Id data source
data "aws_ssm_parameter" "sonar_sg_id" {
    name = "/${var.project}/${var.environment}/sonar_sg_id"               # /roboshop/dev/sonar_sg_id
}