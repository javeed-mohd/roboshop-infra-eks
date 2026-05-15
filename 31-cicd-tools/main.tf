# Creation of Jenkins EC2 Instance
resource "aws_instance" "jenkins" {
  count                   = var.jenkins ? 1 : 0
  ami                     = local.ami_id
  instance_type           = "t3.small"
  subnet_id               = local.public_subnet_id
  vpc_security_group_ids  = [local.jenkins_sg_id]
  user_data               = file("jenkins.sh")

  # Extending the storage
  root_block_device {
    volume_size = 50
    volume_type = "gp3"
    tags = merge(
      {
          Name = "${var.project}-${var.environment}-jenkins"
      },
    local.common_tags
    )
  }

  # roboshop-dev-jenkins
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-jenkins"
    },
    local.common_tags
  )
}

# Creation of Jenkins Agent EC2 Instance
resource "aws_instance" "jenkins_agent" {
  count                   = var.jenkins ? 1 : 0
  ami                     = local.ami_id
  instance_type           = "t3.micro"
  subnet_id               = local.public_subnet_id
  vpc_security_group_ids  = [local.jenkins_agent_sg_id]
  user_data               = file("jenkins-agent.sh")

  # Extending the storage
  root_block_device {
    volume_size = 50
    volume_type = "gp3"
    tags = merge(
      {
          Name = "${var.project}-${var.environment}-jenkins-agent"
      },
    local.common_tags
    )
  }

  # roboshop-dev-jenkins-agent
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-jenkins-agent"
    },
    local.common_tags
  )
}

# Creation of Runner EC2 Instance
resource "aws_instance" "runner" {
  count                   = var.runner ? 1 : 0
  ami                     = local.ami_id
  instance_type           = "t3.micro"
  subnet_id               = local.public_subnet_id
  vpc_security_group_ids  = [local.runner_sg_id]
  user_data               = file("runner.sh")

  # Extending the storage
  root_block_device {
    volume_size = 50
    volume_type = "gp3"
    tags = merge(
      {
          Name = "${var.project}-${var.environment}-runner"
      },
    local.common_tags
    )
  }

  # roboshop-dev-runner
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-runner"
    },
    local.common_tags
  )
}

/*
# Creation of SonarQube EC2 Instance
resource "aws_instance" "sonarqube" {
  count                   = var.sonar ? 1 : 0
  ami                     = local.sonar_ami_id
  instance_type           = "t3.large"
  subnet_id               = local.public_subnet_id      # Replace your Subnet in default VPC
  vpc_security_group_ids  = [local.sonar_sg_id]
  key_name                = "daws-88s"
  
  # Need more for terraform
  root_block_device {
    volume_size = 20
    volume_type = "gp3"     # or "gp2", depending on your preference
  }
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-sonar"
    },
    local.common_tags
  )
}
*/