variable "enabled" {
  default     = "true"
  description = "Set to false to prevent the module from creating or accessing any resources"
}

variable "auto_accept" {
  default     = "true"
  description = "Automatically accept the peering (both VPCs need to be in the same AWS account)"
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

variable "backing_services_allow_remote_vpc_dns_resolution" {
  default     = "true"
  description = "Allow the backing services VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the Kops VPC"
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
