# terraform-aws-kops-vpc-peering [![Build Status](https://travis-ci.org/cloudposse/terraform-aws-kops-vpc-peering.svg?branch=master)](https://travis-ci.org/cloudposse/terraform-aws-kops-vpc-peering)

Terraform module to create a peering connection between a backing services VPC and a VPC created by [Kops](https://github.com/kubernetes/kops).

The module depends on the following [Cloud Posse][website] Terraform modules

- [terraform-aws-kops-metadata](https://github.com/cloudposse/terraform-aws-kops-metadata) - to lookup resources within a Kops cluster
- [terraform-aws-vpc-peering](https://github.com/cloudposse/terraform-aws-vpc-peering) - to create a peering connection between two VPCs


## Usage

```hcl
module "kops_vpc_peering" {
  source                                           = "git::https://github.com/cloudposse/terraform-aws-kops-vpc-peering.git?ref=master"
  namespace                                        = "cp"
  stage                                            = "dev"
  name                                             = "cluster"
  backing_services_vpc_id                          = "vpc-XXXXXXXX"
  dns_zone                                         = "us-west-2.domain.com"
  bastion_name                                     = "bastion"
  masters_name                                     = "masters"
  nodes_name                                       = "nodes"
  backing_services_allow_remote_vpc_dns_resolution = "true"
}
```


## Variables

|  Name                                               |  Default   |  Description                                                                     | Required |
|:----------------------------------------------------|:-----------|:---------------------------------------------------------------------------------|:--------:|
| `namespace`                                         | ``         | Namespace (_e.g._ `cp` or `cloudposse`)                                          | Yes      |
| `stage`                                             | ``         | Stage (_e.g._ `prod`, `dev`, `staging`)                                          | Yes      |
| `name`                                              | ``         | Name  (_e.g._ `app` or `cluster`)                                                | Yes      |
| `backing_services_vpc_id`                           | ``         | Backing services VPC ID                                                          | Yes      |
| `dns_zone`                                          | ``         | Name of the Kops DNS zone                                                        | Yes      |
| `bastion_name`                                      | `bastion`  | Bastion server subdomain name in the `Kops` DNS zone                             | Yes      |
| `masters_name`                                      | `masters`  | K8s masters subdomain name in the `Kops` DNS zone                                | Yes      |
| `nodes_name`                                        | `nodes`    | K8s nodes subdomain name in the `Kops` DNS zone                                  | Yes      |
| `attributes`                                        | `[]`       | Additional attributes (_e.g._ `policy` or `role`)                                | No       |
| `tags`                                              | `{}`       | Additional tags  (_e.g._ `map("BusinessUnit","XYZ")`                             | No       |
| `delimiter`                                         | `-`        | Delimiter to be used between `namespace`, `stage`, `name`, and `attributes`      | No       |
| `enabled`                                           | `true`     | Set to `false` to prevent the module from creating or accessing any resources    | No       |
| `auto_accept`                                       | `true`     | Automatically accept the peering (both VPCs need to be in the same AWS account)  | No       |
| `backing_services_allow_remote_vpc_dns_resolution`  | `true`     | Allow the backing services VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the `Kops` VPC  | No       |


__NOTE:__ The backing services VPC must have subnets associated with route tables.

__NOTE:__ When enabled, the DNS resolution feature (`backing_services_allow_remote_vpc_dns_resolution`)
require that the backing services VPC must have support for the DNS hostnames enabled.

This can be done using the [`enable_dns_hostnames`](https://www.terraform.io/docs/providers/aws/r/vpc.html#enable_dns_hostnames) attribute in the `aws_vpc` resource.

https://www.terraform.io/docs/providers/aws/r/vpc_peering.html#allow_remote_vpc_dns_resolution


## Outputs

| Name                            | Description                                       |
|:--------------------------------|:--------------------------------------------------|
| `connection_id`                 | VPC peering connection ID                         |
| `accept_status`                 | The status of the VPC peering connection request  |
| `kops_vpc_id`                   | Kops VPC ID                                       |


## Credits

Thanks to [Gladly.com](https://www.gladly.com/) for the inspiration with this wonderful module:

https://github.com/sagansystems/terraform-aws-vpc-kops-peering


## Help

**Got a question?**

File a GitHub [issue](https://github.com/cloudposse/terraform-aws-kops-vpc-peering/issues), send us an [email](mailto:hello@cloudposse.com) or reach out to us on [Gitter](https://gitter.im/cloudposse/).


## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/cloudposse/terraform-aws-kops-vpc-peering/issues) to report any bugs or file feature requests.

### Developing

If you are interested in being a contributor and want to get involved in developing `terraform-aws-kops-vpc-peering`, we would love to hear from you! Shoot us an [email](mailto:hello@cloudposse.com).

In general, PRs are welcome. We follow the typical "fork-and-pull" Git workflow.

 1. **Fork** the repo on GitHub
 2. **Clone** the project to your own machine
 3. **Commit** changes to your own branch
 4. **Push** your work back up to your fork
 5. Submit a **Pull request** so that we can review your changes

**NOTE:** Be sure to merge the latest from "upstream" before making a pull request!


## License

[APACHE 2.0](LICENSE) © 2018 [Cloud Posse, LLC](https://cloudposse.com)

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.


## About

`terraform-aws-kops-vpc-peering` is maintained and funded by [Cloud Posse, LLC][website].

![Cloud Posse](https://cloudposse.com/logo-300x69.png)


Like it? Please let us know at <hello@cloudposse.com>

We love [Open Source Software](https://github.com/cloudposse/)!

See [our other projects][community]
or [hire us][hire] to help build your next cloud platform.

  [website]: https://cloudposse.com/
  [community]: https://github.com/cloudposse/
  [hire]: https://cloudposse.com/contact/


## Contributors

| [![Erik Osterman][erik_img]][erik_web]<br/>[Erik Osterman][erik_web] | [![Andriy Knysh][andriy_img]][andriy_web]<br/>[Andriy Knysh][andriy_web] |
|-------------------------------------------------------|------------------------------------------------------------------|

  [erik_img]: http://s.gravatar.com/avatar/88c480d4f73b813904e00a5695a454cb?s=144
  [erik_web]: https://github.com/osterman/
  [andriy_img]: https://avatars0.githubusercontent.com/u/7356997?v=4&u=ed9ce1c9151d552d985bdf5546772e14ef7ab617&s=144
  [andriy_web]: https://github.com/aknysh/
