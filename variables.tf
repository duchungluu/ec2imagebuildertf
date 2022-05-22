################
# Mandatory
################
variable "aws_profile" {
  description = "Name of the aws-profile used for deploying resources"
  type        = string
  default     = "942676077303_AWSAdministratorAccess"
  sensitive   = false
}

variable "default_tags" {
  default = {
    Project = "Cloud Platform"
    Comment = "Managed by Terraform"
  }
}

variable "environment" {
  type      = string
  sensitive = false
  default   = "test"
}

variable "s3_emails" {
  description = "List of emails which to subscribe to S3 Events SNS topic"
  type        = set(string)
  default     = ["ms-noreply-fi@nets.eu"]
  sensitive   = false
}

############
# Optional

variable "ec2_iam_role_name" {
  type      = string
  sensitive = false
  default   = "secure-ec2"
}

variable "aws_region" {
  description = "AWS Region identifier to deploy resources to"
  default     = "eu-central-1"
  type        = string
  sensitive   = false
}

variable "aws_az" {
  description = "AWS Availability Zone identifier to deploy resources to"
  default     = "eu-central-1a"
  type        = string
  sensitive   = false
}

variable "ebs_root_vol_size" {
  default   = 30
  type      = number
  sensitive = false
}
