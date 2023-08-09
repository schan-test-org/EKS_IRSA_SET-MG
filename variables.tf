#################
# BASIC-Configuration
#################
variable "project" {
  description = "project code which used to compose the resource name"
  default     = ""
}

variable "env" {
  description = "environment: dev, stg, qa, prod "
  default     = ""
}

variable "aws_region" {
  description = "aws region to build network infrastructure"
  default     = ""
}

# variable "common_tags" {
#   description = "tags for aws elb tagging"
#   default     = {}
# }

variable "default_tags" { type = map(string) }

#################
# data about remote
#################
variable "tfc_org" { default = "" }
variable "tfc_wk" { default = "" }

#################
# irsa about
#################
variable "irsa" {
  default     = {}
  description = "iam_role, service account specs"
}


#################
# EKS
#################

variable "eks_cluster_name" {
  description = "The name of the eks cluster to retrieve the OIDC information"
  type        = string
}

variable "eks_endpoint_url" {
  type        = string
  default     = ""
  description = "eks endpoint url"
}

variable "eks_cluster_certificate_authority_data" {
  type        = string
  default     = ""
  description = "eks cluster ca certificate"
}

variable "eks_auth_token" {
  type        = string
  default     = ""
  description = "eks cluster auth token"
}

variable "eks_oidc_provider_arn" {
  type        = string
  default     = ""
  description = "openid connect provider arn"
}

variable "eks_oidc_provider_url" {
  type        = string
  default     = ""
  description = "openid connect provider url"
}

