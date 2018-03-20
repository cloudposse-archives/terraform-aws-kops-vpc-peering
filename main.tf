locals {
  requestor_vpc_id    = "${var.backing_services_vpc_id}"
  acceptor_vpc_id     = "${module.kops_metadata.vpc_id}"
  acceptor_subnet_ids = "${module.kops_metadata.private_subnet_ids}"
}

# Lookup VPC + Subnet IDs of the kops cluster
module "kops_metadata" {
  source       = "git::https://github.com/cloudposse/terraform-aws-kops-metadata.git?ref=tags/0.1.0"
  enabled      = "${var.enabled}"
  dns_zone     = "${var.dns_zone}"
  bastion_name = "${var.bastion_name}"
  masters_name = "${var.masters_name}"
  nodes_name   = "${var.nodes_name}"
}

module "label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.3.3"
  enabled    = "${var.enabled}"
  namespace  = "${var.namespace}"
  name       = "${var.name}"
  stage      = "${var.stage}"
  delimiter  = "${var.delimiter}"
  attributes = "${var.attributes}"
  tags       = "${var.tags}"
}

resource "aws_vpc_peering_connection" "default" {
  count       = "${var.enabled == "true" ? 1 : 0}"
  vpc_id      = "${local.requestor_vpc_id}"
  peer_vpc_id = "${local.acceptor_vpc_id}"

  auto_accept = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = "${module.label.tags}"
}

# Lookup requestor VPC so that we can reference the CIDR
data "aws_vpc" "requestor" {
  count = "${var.enabled == "true" ? 1 : 0}"
  id    = "${local.requestor_vpc_id}"
}

# Lookup acceptor VPC so that we can reference the CIDR
data "aws_vpc" "acceptor" {
  count = "${var.enabled == "true" ? 1 : 0}"
  id    = "${local.acceptor_vpc_id}"
}

# Create a route from requestor to acceptor
resource "aws_route" "requestor" {
  count                     = "${var.enabled == "true" ? length(distinct(sort(var.route_table_ids))) : 0}"
  route_table_id            = "${element(distinct(sort(var.route_table_ids)), count.index)}"
  destination_cidr_block    = "${data.aws_vpc.acceptor.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.default.id}"
}

# Lookup acceptor routing tables
data "aws_route_table" "acceptor" {
  count     = "${var.enabled == "true" ? length(distinct(sort(local.acceptor_subnet_ids))) : 0}"
  subnet_id = "${element(distinct(sort(local.acceptor_subnet_ids)), count.index)}"
}

# Create a route from acceptor to requestor
resource "aws_route" "acceptor" {
  count                     = "${var.enabled == "true" ? length(distinct(sort(data.aws_route_table.acceptor.*.route_table_id))) : 0}"
  route_table_id            = "${element(distinct(sort(data.aws_route_table.acceptor.*.route_table_id)), count.index)}"
  destination_cidr_block    = "${data.aws_vpc.requestor.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.default.id}"
}
