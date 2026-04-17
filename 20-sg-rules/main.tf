# Creation of BASTION Security Group Rule, it should accept connection from internet
resource "aws_security_group_rule" "bastion_internet" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  # cidr_blocks              = [local.my_ip] # Public_ip keeps changing with mobile hotspot 
  #   For which security group you are creating this rule.
  security_group_id        = local.bastion_sg_id 
}

# Creation of MONGODB Security Group Rule, it should accept connection from bastion
resource "aws_security_group_rule" "mongodb_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.bastion_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.mongodb_sg_id 
}

# Creation of REDIS Security Group Rule, it should accept connection from bastion 
resource "aws_security_group_rule" "redis_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.bastion_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.redis_sg_id 
}

# Creation of MySQL Security Group Rule, it should accept connection from bastion
resource "aws_security_group_rule" "mysql_bastion" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.bastion_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.mysql_sg_id 
}

# Creation of MySQL Security Group Rule, it should accept connection from EKS Node
resource "aws_security_group_rule" "mysql_eks_node" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.eks_node_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.mysql_sg_id 
}

# Creation of RABBITMQ Security Group Rule, it should accept connection from bastion
resource "aws_security_group_rule" "rabbitmq_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.bastion_sg_id # Either cidr block or security group should be used...
  security_group_id        = local.rabbitmq_sg_id 
}

# Creation of INGRESS ALB (Application Load Balancer) Security Group Rule, it should accept connection from public
resource "aws_security_group_rule" "ingress_alb_public" {
  type              = "ingress"
  from_port         = 443       # HTTPS (LoadBalancer), Because AWS won't give access to SSH 22
  to_port           = 443
  protocol          = "tcp"
  # Where traffic is coming from
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.ingress_alb_sg_id
}

# Creation of Openvpn Security Group Rule, it should accept connection from public 443 (Outside)
# OpenVPN is an open-source software application used to create a secure connection over the internet, commonly known as a Virtual Private Network (VPN).
resource "aws_security_group_rule" "openvpn_public_443" {
  type              = "ingress"
  from_port         = 443        # HTTPS (LoadBalancer), Because AWS won't give access to SSH 22
  to_port           = 443
  protocol          = "tcp"
  # Where traffic is coming from
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.openvpn_sg_id
}

# Creation of Openvpn Security Group Rule, it should accept connection from public 943 (UI)
# Admin UI (https://public_ip of openvpn instance/admin)
resource "aws_security_group_rule" "openvpn_public_943" {
  type              = "ingress"
  from_port         = 943         # HTTPS (LoadBalancer), Because AWS won't give access to SSH 22
  to_port           = 943
  protocol          = "tcp"
  # Where traffic is coming from
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.openvpn_sg_id
}

# Creation of EKS Control Plane Security Group Rule, it should accept connection from bastion
resource "aws_security_group_rule" "eks_control_plane_bastion" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.bastion_sg_id  # Either cidr block or security group should be used...
  security_group_id        = local.eks_control_plane_sg_id 
}

# Creation of EKS Node Security Group Rule, it should accept connection from bastion
resource "aws_security_group_rule" "eks_node_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  # Where traffic is coming from?
  source_security_group_id = local.bastion_sg_id  # Either cidr block or security group should be used...
  security_group_id        = local.eks_node_sg_id 
}

# Creation of EKS Control Plane Security Group Rule, it should accept connection from EKS Node
resource "aws_security_group_rule" "eks_control_plane_eks_node" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"     # All traffic
  # Where traffic is coming from?
  source_security_group_id = local.eks_node_sg_id  # Either cidr block or security group should be used...
  security_group_id        = local.eks_control_plane_sg_id 
}

# Creation of EKS Node Security Group Rule, it should accept connection from EKS Control Plane
resource "aws_security_group_rule" "eks_node_eks_control_plane" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"     # All traffic
  # Where traffic is coming from?
  source_security_group_id = local.eks_control_plane_sg_id  # Either cidr block or security group should be used...
  security_group_id        = local.eks_node_sg_id 
}

# Creation of EKS Node Security Group Rule, it should accept connection from VPC Classless Inter Domain Routing (CIDR)
resource "aws_security_group_rule" "eks_node_vpc_cidr" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"     # All traffic
  # Where traffic is coming from? VPC CIDR
  cidr_blocks              = ["10.0.0.0/16"]    # Either cidr block or security group should be used...
  security_group_id        = local.eks_node_sg_id 
}