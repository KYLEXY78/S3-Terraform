# Configuring the Terraform Provider

terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>5.66.0"
        }
    }

}


#Configuring AWS Provider

provider "aws" {
    region = "us-east-1"
}