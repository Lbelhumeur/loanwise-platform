variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "repository" {
  type = string
}

variable "aws_account_id" {
  type      = string
  sensitive = true
}

variable "aws_region" {
  type = string
}

variable "github_owner_id" {
  type = string
}

variable "github_repository_id" {
  type = string
}
