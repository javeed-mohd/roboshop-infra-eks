# project/project_name can be used as you wish(Not necessarily it should be same but it gives the exact default value provided).
variable "project" {
  default   = "roboshop"
}

variable "environment" {
  default   = "dev"
}

variable "eks_version" {
  default   = "1.34"
}

variable "enable_blue" {
  default   = true
}

variable "enable_green" {
  default   = false
}

variable "eks_nodegroup_blue_version" {
  default   = ""
}

variable "eks_nodegroup_green_version" {
  default   = ""
}