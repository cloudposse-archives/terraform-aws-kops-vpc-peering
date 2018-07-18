
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| attributes | Additional attributes (e.g. `policy` or `role`) | list | `<list>` | no |
| auto_accept | Automatically accept the peering (both VPCs need to be in the same AWS account) | string | `true` | no |
| backing_services_allow_remote_vpc_dns_resolution | Allow the backing services VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the Kops VPC | string | `true` | no |
| backing_services_vpc_id | Backing services VPC ID | string | - | yes |
| bastion_name | Bastion server subdomain name in the Kops DNS zone | string | `bastion` | no |
| delimiter | Delimiter to be used between `namespace`, `stage`, `name`, and `attributes` | string | `-` | no |
| dns_zone | Name of the Kops DNS zone | string | - | yes |
| enabled | Set to false to prevent the module from creating or accessing any resources | string | `true` | no |
| masters_name | K8s masters subdomain name in the Kops DNS zone | string | `masters` | no |
| name | Name  (e.g. `app` or `cluster`) | string | - | yes |
| namespace | Namespace (e.g. `cp` or `cloudposse`) | string | - | yes |
| nodes_name | K8s nodes subdomain name in the Kops DNS zone | string | `nodes` | no |
| stage | Stage (e.g. `prod`, `dev`, `staging`) | string | - | yes |
| tags | Additional tags (e.g. map('BusinessUnit`,`XYZ`) | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| accept_status | The status of the VPC peering connection request |
| connection_id | VPC peering connection ID |
| kops_vpc_id | Kops VPC ID |

