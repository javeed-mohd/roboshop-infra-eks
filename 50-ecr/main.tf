# Catalogue ECR repository
resource "aws_ecr_repository" "catalogue" {
  name                 = "${var.project}/catalogue"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  force_delete = true
}

# User ECR repository
resource "aws_ecr_repository" "user" {
  name                 = "${var.project}/user"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  force_delete = true
}

# Cart ECR repository
resource "aws_ecr_repository" "cart" {
  name                 = "${var.project}/cart"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  force_delete = true
}

# Shipping ECR repository
resource "aws_ecr_repository" "shipping" {
  name                 = "${var.project}/shipping"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  force_delete = true
}

# Payment ECR repository
resource "aws_ecr_repository" "payment" {
  name                 = "${var.project}/payment"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  force_delete = true
}

# Frontend ECR repository
resource "aws_ecr_repository" "frontend" {
  name                 = "${var.project}/frontend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  force_delete = true
}