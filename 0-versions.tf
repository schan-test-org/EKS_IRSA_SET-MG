############################################
# version of terraform and providers
############################################
terraform {
  cloud {
    organization = "schan-test"

    workspaces {}
  }
}


# terraform {
#   required_version = ">= 1.2.5"
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = ">= 4.0.0"
#     }
#     kubernetes = {
#       source  = "hashicorp/kubernetes"
#       version = ">= 2.0.0"
#     }
#     random = {
#       source  = "hashicorp/random"
#       version = ">= 3.0.0"
#     }
#   }
# }

############################# random about #######################################

resource "random_string" "random" {
  length  = 3
  special = false
  upper   = false
}

# resource "random_id" "id" {
#   byte_length = 8
# }
