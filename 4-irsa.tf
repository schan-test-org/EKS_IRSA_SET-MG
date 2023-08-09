
module "irsa" {
  #always replace with latest version from Github
  #   source = "github.com/ministryofjustice/cloud-platform-terraform-irsa?ref=1.0.6"
  # EKS configuration
  # eks_cluster_name = local.eks_cluster_name

  source   = "./md-irsa"
  for_each = var.irsa

  # IRSA configuration
  oidc_provider = {
    provider = "aws"
    url      = local.eks_oidc_provider_url
    arn      = local.eks_oidc_provider_arn
  }

  irsa_info = {
    name                            = each.value.name == "" ? each.key : each.value.name
    namespace                       = try(each.value.namespace, "default")
    automount_token                 = try(each.value.automount_token, false)
    iam_role_name                   = try(each.value.iam_role_name, "")
    iam_role_exist_managed_policies = try(each.value.iam_role_exist_managed_policies, [])
  }

  common_tags = local.common_tags

}

# resource "kubernetes_secret" "irsa" {
#   metadata {
#     name      = "${var.team_name}-irsa"
#     namespace = var.namespace
#   }
#   data = {
#     role           = module.irsa.role_name
#     serviceaccount = module.irsa.service_account.name
#   }
# }


################################################################
# data "aws_iam_policy_document" "document" {
#   statement {
#     actions = [
#       "s3:*",
#     ]
#     resources = [
#       "arn:aws:s3:::*",
#     ]
#   }
# }

# resource "aws_iam_policy" "policy" {
#   name        = "simple-policy-for-testing-irsa"
#   path        = "/cloud-platform/"
#   policy      = data.aws_iam_policy_document.document.json
#   description = "Policy for testing cloud-platform-terraform-irsa"
# }
