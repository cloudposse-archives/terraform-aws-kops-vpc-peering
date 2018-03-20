output "connection_id" {
  value = "${join("", aws_vpc_peering_connection.default.*.id)}"
}

output "kops_vpc_id" {
  value = "${module.kops_metadata.vpc_id}"
}
