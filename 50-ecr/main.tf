; # Catalogue ECR repository
; resource "aws_ecr_repository" "catalogue" {
;   name                 = "${var.project}/catalogue"
;   image_tag_mutability = "MUTABLE"
;   force_delete         = true

;   image_scanning_configuration {
;     scan_on_push = false
;   }
; }

; # User ECR repository
; resource "aws_ecr_repository" "user" {
;   name                 = "${var.project}/user"
;   image_tag_mutability = "MUTABLE"
;   force_delete         = true

;   image_scanning_configuration {
;     scan_on_push = false
;   }
; }

; # Cart ECR repository
; resource "aws_ecr_repository" "cart" {
;   name                 = "${var.project}/cart"
;   image_tag_mutability = "MUTABLE"
;   force_delete         = true

;   image_scanning_configuration {
;     scan_on_push = false
;   }
; }

; # Shipping ECR repository
; resource "aws_ecr_repository" "shipping" {
;   name                 = "${var.project}/shipping"
;   image_tag_mutability = "MUTABLE"
;   force_delete         = true

;   image_scanning_configuration {
;     scan_on_push = false
;   }
; }

; # Payment ECR repository
; resource "aws_ecr_repository" "payment" {
;   name                 = "${var.project}/payment"
;   image_tag_mutability = "MUTABLE"
;   force_delete         = true

;   image_scanning_configuration {
;     scan_on_push = false
;   }
; }

; # Frontend ECR repository
; resource "aws_ecr_repository" "frontend" {
;   name                 = "${var.project}/frontend"
;   image_tag_mutability = "MUTABLE"
;   force_delete         = true

;   image_scanning_configuration {
;     scan_on_push = false
;   }
; }

# Backend and Frontend components Elastic Container Registry repositories
resource "aws_ecr_repository" "repos" {
  for_each = toset([
    "catalogue",
    "user",
    "cart",
    "shipping",
    "payment",
    "frontend"
  ])

  name                 = "${var.project}/${each.value}"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = false
  }

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-${each.value}"
    }
  )
}