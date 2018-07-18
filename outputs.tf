output "connection_id" {
  value       = "${module.vpc_peering.connection_id}"
  description = "VPC peering connection ID"
}

output "accept_status" {
  value       = "${module.vpc_peering.accept_status}"
  description = "The status of the VPC peering connection request"
}

output "kops_vpc_id" {
  value       = "${module.kops_metadata.vpc_id}"
  description = "Kops VPC ID"
}
