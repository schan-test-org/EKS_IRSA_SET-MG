
## EKS IRSA SET_UP

===

용도:

- EKS 상에서 AWS 리소스 사용을 위한 IRSA 생성/셋업 및 관리

===

### tfvars 예시

```terraform

###############################################################################
# EKS & IRSA about
###############################################################################
eks_cluster_name = "custom-eks"

irsa = {
  s3_irsa = {
    "name"                            = "s3-access-for-eks-sa"   # 사전에 해당 ns 상에 동일한 이름 sa 가 존재하지 않는 지 확인필요
    "namespace"                       = "default-2"              # 기존에 존재하는 ns 확인 후 존재하지 않는 경우, 신규생성 되도록 모듈 내의 컨디션 조건 추가
    "iam_role_name"                   = "s3-access-role"         # 동일한 role 이 중복되지 않도록 모듈에서 random string 3 suffix 추가
    "iam_role_exist_managed_policies" = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]
    "automount_token"                 = false
  }

  # metrics_irsa = {
  #   "name"                            = "<신규 sa name>"
  #   "namespace"                       = "<ns name>"
  #   "iam_role_name"                   = "<신규 aws-role name>"
  #   "iam_role_exist_managed_policies" = ["<매니지드 정책 또는 사전에 만들어둔 커스텀 정책 arn>"]
  #   "automount_token"                 = false
  # }
}

```

### using module 예시

```terraform
module "irsa" {

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
```
