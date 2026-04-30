# project/project_name can be used as you wish(Not necessarily it should be same but it gives the exact default value provided).
variable "project" {
  default   = "roboshop"
}

variable "environment" {
  default   = "dev"
}

# Security group names list
variable "sg_names" {
  type      = list
  default   = [
    # Databases
    "mongodb", "redis", "mysql", "rabbitmq",
    # Ingress Application Load Balancer (ALB)
    "ingress_alb",
    # Bastion --> A bastion host is a special server that acts as a secure gateway to access resources inside a private network (like private VMs or instances).
    "bastion",
    # Openvpn --> OpenVPN is an open-source software application used to create a secure connection over the internet, commonly known as a Virtual Private Network (VPN).
    "openvpn",
    "eks_control_plane","eks_node",
    "jenkins","jenkins_agent",
    "sonar"
  ]
}