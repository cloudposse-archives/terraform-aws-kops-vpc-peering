variable "enabled" {
  default     = "true"
  description = "Set to false to prevent the module from creating or accessing any resources"
}

variable "dns_zone" {
  type        = "string"
  description = "Name of the Kops DNS zone"
}

variable "bastion_name" {
  type        = "string"
  default     = "bastion"
  description = "Bastion server subdomain name in the Kops DNS zone"
}

variable "masters_name" {
  type        = "string"
  default     = "masters"
  description = "K8s masters subdomain name in the Kops DNS zone"
}

variable "nodes_name" {
  type        = "string"
  default     = "nodes"
  description = "K8s nodes subdomain name in the Kops DNS zone"
}

variable "backing_services_vpc_id" {
  type        = "string"
  description = "Backing services VPC ID"
}

variable "route_table_ids" {
  type        = "list"
  description = "List of route table IDs to create routes from requestor VPC to acceptor VPC"
}

variable "namespace" {
  description = "Namespace (e.g. `cp` or `cloudposse`)"
  type        = "string"
}

variable "stage" {
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
  type        = "string"
}

variable "name" {
  description = "Name  (e.g. `app` or `cluster`)"
  type        = "string"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `namespace`, `stage`, `name`, and `attributes`"
}

variable "attributes" {
  type        = "list"
  default     = []
  description = "Additional attributes (e.g. `policy` or `role`)"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. map('BusinessUnit`,`XYZ`)"
}
