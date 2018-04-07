# Lookup the backing services VPC
data "aws_vpc" "requester" {
  filter {
    name   = "tag:Name"
    values = ["${var.backing_services_vpc_name}"]
  }
}

# Lookup VPC of the kops cluster
data "aws_vpc" "accepter" {
  filter {
    name   = "tag:Name"
    values = ["${var.kops_vpc_name}"]
  }
}

resource "aws_vpc_peering_connection" "default" {
  vpc_id      = "${data.aws_vpc.requester.id}"
  peer_vpc_id = "${data.aws_vpc.accepter.id}"

  auto_accept = "${var.auto_accept}"

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = "${var.tags}"
}

# Lookup requester subnets
data "aws_subnet_ids" "requester" {
  vpc_id = "${data.aws_vpc.requester.id}"
}

# Lookup requester route tables
data "aws_route_table" "requester" {
  count     = "${length(distinct(sort(data.aws_subnet_ids.requester.ids)))}"
  subnet_id = "${element(distinct(sort(data.aws_subnet_ids.requester.ids)), count.index)}"
}

# Lookup accepter subnets
data "aws_subnet_ids" "accepter" {
  vpc_id = "${data.aws_vpc.accepter.id}"
}

# Lookup accepter route tables
data "aws_route_table" "accepter" {
  count     = "${length(distinct(sort(data.aws_subnet_ids.accepter.ids)))}"
  subnet_id = "${element(distinct(sort(data.aws_subnet_ids.accepter.ids)), count.index)}"
}

# Create a route from requester to accepter
resource "aws_route" "requester" {
  count                     = "${length(distinct(sort(data.aws_route_table.requester.*.route_table_id)))}"
  route_table_id            = "${element(distinct(sort(data.aws_route_table.requester.*.route_table_id)), count.index)}"
  destination_cidr_block    = "${data.aws_vpc.accepter.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.default.id}"
  depends_on                = ["data.aws_route_table.requester", "aws_vpc_peering_connection.default"]
}

# Create a route from accepter to requester
resource "aws_route" "accepter" {
  count                     = "${length(distinct(sort(data.aws_route_table.accepter.*.route_table_id)))}"
  route_table_id            = "${element(distinct(sort(data.aws_route_table.accepter.*.route_table_id)), count.index)}"
  destination_cidr_block    = "${data.aws_vpc.requester.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.default.id}"
  depends_on                = ["data.aws_route_table.accepter", "aws_vpc_peering_connection.default"]
}
