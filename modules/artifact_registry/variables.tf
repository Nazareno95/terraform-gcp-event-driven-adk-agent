variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "repository_id" {
  type    = string
  default = "adk-agent-images"
}

variable "description" {
  type    = string
  default = "Docker images for event-driven ADK agent"
}

variable "labels" {
  type    = map(string)
  default = {}
}