variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "db_name" {
  type    = string
  default = "sengoku"
}

variable "db_username" {
  type    = string
  default = "postgres"
}

variable "db_password" {
  type    = string
  default = "sengoku123"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "s3_bucket_name" {
  type    = string
  default = "sengoku-static-isoea"
}
