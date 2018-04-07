variable "auto_accept" {
  default     = "true"
  description = "Automatically accept the peering (both VPCs need to be in the same AWS account)"
}

variable "kops_vpc_name" {
  type        = "string"
  description = "Kops VPC name"
}

variable "backing_services_vpc_name" {
  type        = "string"
  default     = "bastion"
  description = "Backing services VPC name"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. map('BusinessUnit`,`XYZ`)"
}
