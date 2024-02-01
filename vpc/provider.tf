#configure terraform AWS provider

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # stores the terraform state file in S3
  backend "s3" {
    bucket  = "rama-s3state14"
    key     = "state/terraform.tfstate.dev"
    region  = "us-east-1"
    encrypt = true


  }
}
