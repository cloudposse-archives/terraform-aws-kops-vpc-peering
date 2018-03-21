output "connection_id" {
  value = "${module.vpc_peering.connection_id}"
}

output "accept_status" {
  value = "${module.vpc_peering.accept_status}"
}

output "kops_vpc_id" {
  value = "${module.kops_metadata.vpc_id}"
}
