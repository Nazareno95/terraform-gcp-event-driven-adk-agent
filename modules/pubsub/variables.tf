variable "project_id" {
  type = string
}

variable "topic_name" {
  type = string
}

variable "subscription_name" {
  type = string
}

variable "ack_deadline_seconds" {
  type    = number
  default = 60
}

variable "message_retention_duration" {
  type    = string
  default = "604800s"
}

variable "labels" {
  type    = map(string)
  default = {}
}