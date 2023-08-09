###############################################################################
# Common Variables
###############################################################################
project    = "testmz-irsa"
aws_region = "ap-northeast-2"

default_tags = {
  dept  = "Platform Service Architect Group / DevOps SWAT Team"
  email = "schan@mz.co.kr"
}

env = "dev"

###############################################################################
# EKS & IRSA about
###############################################################################
eks_cluster_name = "custom-eks"

irsa = {
  s3_irsa = {
    "name"                            = "s3-access-for-eks-sa" # 사전에 해당 ns 상에 동일한 이름 sa 가 존재하지 않는 지 확인필요
    "namespace"                       = "default-2"            # 기존에 존재하는 ns 확인 후 존재하지 않는 경우, 신규생성 되도록 모듈 내의 컨디션 조건 추가
    "iam_role_name"                   = "s3-access-role"       # 동일한 role 이 중복되지 않도록 모듈에서 random string 3 suffix 추가
    "iam_role_exist_managed_policies" = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]
    "automount_token"                 = false
  }

  # metrics_irsa = {
  #   "name"                            = "<sa name>"
  #   "namespace"                       = "<존재하는 ns>"
  #   "iam_role_name"                   = "<aws-role name>"
  #   "iam_role_exist_managed_policies" = ["<매니지드 정책 또는 사전에 만들어둔 커스텀 정책 arn>"]
  #   "automount_token"                 = false
  # }
}

###############################################################################
# remote-data about
###############################################################################
# backend_remote_organization      = "schan-test"
# backend_remote_eks_workspace     = "custom-eks"
# backend_remote_network_workspace = "dev-subnet-tfc"

tfc_org = "schan-test"
tfc_wk  = "custom-eks"
