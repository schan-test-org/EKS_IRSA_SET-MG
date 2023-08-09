locals {
  # AWS IAM Role annotaitions
  # - eks.amazonaws.com/role-arn
  # - eks.amazonaws.com/sts-regional-endpoints
  annotaions = tomap({ "eks.amazonaws.com/role-arn" : "${aws_iam_role.this.arn}", "eks.amazonaws.com/sts-regional-endpoints" : true })
  create_ns  = contains(data.kubernetes_all_namespaces.allns.namespaces, var.irsa_info.namespace) ? 0 : 1
  # create_ns  = lookup(data.kubernetes_namespace.checking, "id") == null ? 1 : 0

}


data "kubernetes_all_namespaces" "allns" {}

resource "kubernetes_namespace" "this" {
  count = local.create_ns
  metadata {
    name = var.irsa_info.namespace
  }
  depends_on = [data.kubernetes_all_namespaces.allns]
}

resource "kubernetes_service_account" "this" {
  metadata {
    name        = var.irsa_info.name
    namespace   = var.irsa_info.namespace
    annotations = local.annotaions
    labels      = {}
  }
  automount_service_account_token = try(var.irsa_info.automount_token, false)
}
