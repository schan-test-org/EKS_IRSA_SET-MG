############################################
# AWS Provider Configuration
############################################
provider "aws" {
  region = var.aws_region
  # profile = var.aws_profile
}

provider "kubernetes" {
  cluster_ca_certificate = base64decode(local.eks_cluster_certificate_authority_data)
  host                   = local.eks_endpoint_url
  token                  = local.eks_auth_token
  # token                  = data.aws_eks_cluster_auth.cluster.token
}
