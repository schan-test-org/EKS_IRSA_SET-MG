############################# data : local #######################################
locals {
  region = var.aws_region
  # eks_package_bucket_name   = var.backend_s3_bucket_name
  # eks_package_bucket_key    = var.eks_s3_key
  # eks_package_bucket_region = var.region
}

############################# data : aws_caller #######################################
data "aws_caller_identity" "current" {

}

############################# data : k8s #######################################
data "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

}
data "aws_eks_cluster_auth" "cluster" {
  name = local.eks_cluster_name
}

############################# data : remote #######################################

# data "terraform_remote_state" "eks" {
#   backend = "s3"
#   config = {
#     bucket = local.eks_package_bucket_name
#     key    = local.eks_package_bucket_key
#     region = local.eks_package_bucket_region
#   }
# }

data "terraform_remote_state" "eks" {
  # count = var.vpc_id == "" ? 1 : 0

  backend = "remote"
  config = {
    organization = var.tfc_org
    workspaces = {
      name = var.tfc_wk
    }
  }

}
