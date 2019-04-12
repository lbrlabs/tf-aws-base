variable "cidr_block" {
  description = "The cidr block for a VPC"
}

variable "namespace" {
  description = "A unique namespace for this infrastructure"
}

variable "stage" {
  description = "The stage for this infrastructure (dev|stg|prod)"
}

variable "name" {
  description = "Name of this infrastructure"
}

variable "region" {
  description = "AWS Region to operator in"
}
