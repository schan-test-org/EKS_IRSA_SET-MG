################################################################

variable "irsa_info" {
  type = object({
    name                            = optional(string, "")
    namespace                       = optional(string, "")
    automount_token                 = optional(bool, false)
    iam_role_name                   = optional(string, "")
    iam_role_exist_managed_policies = optional(list(string), [])
  })
  default     = {}
  description = "iam_role, service account specs"
}


variable "oidc_provider" {
  default     = {}
  description = "eks cluster oidc provider"
}


################################################################

variable "common_tags" {
  default     = {}
  description = "common tags"
}

# variable "account_id" {
#   default     = {}
#   description = "aws account id"
# }
