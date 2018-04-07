output "connection_id" {
  value = "${aws_vpc_peering_connection.default.id}"
}

output "accept_status" {
  value = "${aws_vpc_peering_connection.default.accept_status}"
}

output "kops_vpc_id" {
  value = "${data.aws_vpc.accepter.id}"
}

output "backing_services_vpc_id" {
  value = "${data.aws_vpc.requester.id}"
}
