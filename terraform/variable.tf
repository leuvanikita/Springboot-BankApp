
variable "aws_region" {
  default = "eu-west-1"
  type = string
  description = "AWS region"

}

variable "instance_type" {
  default = "t2.large"
  type = string
  description = "AWS EC2 instance"
  
}

variable "aws_env" {
  default = "dev"
  type = string
  description = "Aws environment for infra"

}

variable "ami_id" {
  default = "ami-049442a6cf8319180"  #ubuntu
  type = string
  description = "AWS OS image"
}
