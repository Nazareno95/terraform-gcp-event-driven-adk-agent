variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "service_name" {
  type = string
}

variable "image" {
  type = string
}

variable "service_account_email" {
  type = string
}

variable "dataset_id" {
  type = string
}

variable "audit_table" {
  type    = string
  default = "agent_audit_log"
}

variable "labels" {
  type    = map(string)
  default = {}
}