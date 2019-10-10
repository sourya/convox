variable "name" {
  type = "string"
}

variable "namespace" {
  type = "string"
}

variable "nodes_role" {
  type = "string"
}

variable "nodes_security" {
  type = "string"
}

variable "release" {
  type = "string"
}

variable "subnets" {
  type = "list"
}

variable "target_group_http" {
  type = "string"
}

variable "target_group_https" {
  type = "string"
}
