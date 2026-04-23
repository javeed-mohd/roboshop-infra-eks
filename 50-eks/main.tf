; module "eks" {
;   source  = "terraform-aws-modules/eks/aws"
;   version = "~> 21.0"

;   name               = "${var.project}-${var.environment}"
;   kubernetes_version = "1.34"

;   addons = {
;     coredns                = {}
;     eks-pod-identity-agent = {
;       before_compute = true
;     }
;     kube-proxy             = {}
;     vpc-cni                = {
;       before_compute = true
;     }
;     metrics-server = {}
;   }

;   # Optional
;   endpoint_public_access = false

;   # Optional: Adds the current caller identity as an administrator via cluster access entry
;   enable_cluster_creator_admin_permissions = true

;   vpc_id                        = local.vpc_id
;   subnet_ids                    = local.private_subnet_ids
;   control_plane_subnet_ids      = local.private_subnet_ids
;   create_node_security_group    = false
;   create_security_group         = false
;   node_security_group_id        = local.eks_node_sg_id
;   security_group_id             = local.eks_control_plane_sg_id     # Master Node

;   # EKS Managed Node Group(s)
;   eks_managed_node_groups = {
;     blue = {
;       # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
;       ami_type       = "AL2023_x86_64_STANDARD"
;       instance_types = ["m5.xlarge"]
;       iam_role_additional_policies = {
;         amazonEBS = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
;         amazonEFS = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
;       }
;       # Cluster Node Autoscaling
;       min_size     = 2
;       max_size     = 10
;       desired_size = 2
;     }
;   }

;   tags = merge (
;     local.common_tags,
;     {
;         Name = "${var.project}-${var.environment}"
;     }
;   )
; }

module "eks" {
  source = "../../terraform-aws-eks"

  project     = var.project
  environment = var.environment

  cluster_version            = var.eks_version
  vpc_id                     = local.vpc_id
  private_subnet_ids         = local.private_subnet_ids
  cluster_security_group_ids = [local.eks_control_plane_sg_id]
  node_security_group_ids    = [local.eks_node_sg_id]

  eks_managed_node_groups = {
    blue = {
      create             = var.enable_blue
      kubernetes_version = var.eks_nodegroup_blue_version
      instance_types     = ["c3.large", "c4.large", "c5.large", "c5d.large", "c5n.large", "c5a.large"]
      capacity_type  = "SPOT"
      min_size       = 2
      max_size       = 10
      desired_size   = 2
      labels         = { nodegroup = "blue" }
      iam_role_additional_policies = {
        amazonEBS = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        amazonEFS = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
      }
    }

    green = {
      create             = var.enable_green
      kubernetes_version = var.eks_nodegroup_green_version
      instance_types     = ["c3.large", "c4.large", "c5.large", "c5d.large", "c5n.large", "c5a.large"]
      capacity_type      = "SPOT"
      min_size           = 2
      max_size           = 10
      desired_size       = 2
      labels             = { nodegroup = "green" }
      iam_role_additional_policies = {
        amazonEBS = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        amazonEFS = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
      }
    }
  }

  cluster_tags = local.common_tags
}