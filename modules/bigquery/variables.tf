variable "project_id" {
  type = string
}

variable "dataset_id" {
  type = string
}

variable "location" {
  type    = string
  default = "US"
}

variable "delete_contents_on_destroy" {
  type    = bool
  default = false
}

variable "deletion_protection" {
  type    = bool
  default = true
}

variable "labels" {
  type    = map(string)
  default = {}
}