# Assume role policy
data "aws_iam_policy_document" "this" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(var.oidc_provider.url, "https://", "")}:sub"
      values   = [format("system:serviceaccount:%s:%s", var.irsa_info.namespace, var.irsa_info.name)]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(var.oidc_provider.url, "https://", "")}:aud"
      values   = ["sts.amazonaws.com"]
    }

    principals {
      identifiers = [var.oidc_provider.arn]
      type        = "Federated"
    }
  }
}
#####
resource "random_string" "x" {
  length  = 3
  special = false
  upper   = false
}
########

resource "aws_iam_role" "this" {
  assume_role_policy = data.aws_iam_policy_document.this.json
  name               = "${var.irsa_info.iam_role_name}-${random_string.x.result}"

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    var.common_tags,
    tomap({ "Name" = var.irsa_info.iam_role_name })
  )
}

resource "aws_iam_role_policy_attachment" "exist_managed_policies" {
  for_each   = setunion(var.irsa_info.iam_role_exist_managed_policies)
  policy_arn = each.value
  role       = aws_iam_role.this.name

  depends_on = [
    aws_iam_role.this
  ]
}
