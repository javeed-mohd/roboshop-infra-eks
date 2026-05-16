# project/project_name can be used as you wish(Not necessarily it should be same but it gives the exact default value provided).
variable "project" {
  default   = "roboshop"
}

variable "environment" {
  default   = "dev"
}

variable "zone_id" {
  default   = "Z0883755364LI3FEBC65Q"
}

variable "domain_name" {
  default   = "devopsdaws.online"
}

# Set to false to skip SonarQube instance and its DNS record creation
variable "sonar" {
  default   = false
}

# Set to false to skip Jenkins instance and its DNS record creation while using Runner
variable "jenkins" {
    default = true
}

# Set to true to get Runner instance while using Runner
variable "runner" {
    default = false
}