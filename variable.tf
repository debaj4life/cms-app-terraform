variable "region" {
  type        = string
  description = "aws region"
  default     = "eu-west-2"
}

variable "instance_type" {
  type        = string
  description = "instance type"
  default     = "t3.medium"
}

variable "ami_id" {
  type        = string
  description = "ami"
  default     = "ami-0acc77abdfc7ed5a6"
}

variable "environment" {
  type        = string
  description = "environment to build"
  default     = "dev"
}

variable "vpc_id" {
  type        = string
  description = "vpc"
  default     = "vpc-071a935c677dbb90c"
}

variable "key_name" {
  type        = string
  description = "key"
  default     = "tutorial-key"
}

variable "desired_capacity" {
  type        = number
  description = "desired_capacity"
  default     = 1
}

variable "max_size" {
  type        = number
  description = "max"
  default     = 1
}

variable "min_size" {
  type        = number
  description = "min"
  default     = 1
}

variable "subnets" {
  type        = list(string)
  description = "subnets"
  default     = ["subnet-0ac8b28d64573460b", "subnet-08b711d075f9a142a", "subnet-0a66a5cfe19424c28"]
}

variable "zone_id" {
  type = string
  description = "zone id"
  default = "Z01752471FYWFTVEJ68WX"
}
