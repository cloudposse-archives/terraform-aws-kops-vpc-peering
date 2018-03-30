# Lookup VPC of the kops cluster
module "kops_metadata" {
  source       = "git::https://github.com/cloudposse/terraform-aws-kops-metadata.git?ref=tags/0.1.1"
  enabled      = "${var.enabled}"
  dns_zone     = "${var.dns_zone}"
  bastion_name = "${var.bastion_name}"
  masters_name = "${var.masters_name}"
  nodes_name   = "${var.nodes_name}"
}

# Create a peering connection between the backing services VPC and Kops VPC
module "vpc_peering" {
  source                                    = "git::https://github.com/cloudposse/terraform-aws-vpc-peering.git?ref=tags/0.1.0"
  enabled                                   = "${var.enabled}"
  namespace                                 = "${var.namespace}"
  name                                      = "${var.name}"
  stage                                     = "${var.stage}"
  delimiter                                 = "${var.delimiter}"
  attributes                                = "${var.attributes}"
  tags                                      = "${var.tags}"
  auto_accept                               = "${var.auto_accept}"
  requestor_vpc_id                          = "${var.backing_services_vpc_id}"
  acceptor_vpc_id                           = "${module.kops_metadata.vpc_id}"
  requestor_allow_remote_vpc_dns_resolution = "${var.backing_services_allow_remote_vpc_dns_resolution}"
  acceptor_allow_remote_vpc_dns_resolution  = "true"
}
