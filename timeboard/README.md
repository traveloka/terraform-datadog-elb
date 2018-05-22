terraform-datadog-timeboard-elb
=================

Terraform module to create Datadog Timeboard for ELB.



Usage
-----

```hcl
module "timeboard_elb_beical-lbint-01" {
  source         = "github.com/traveloka/terraform-datadog-elb//timeboard"
  product_domain = "BEI"
  lb_name        = "beical-lbint"
  lb_type        = "application" //Either application or classic for now
}
```

Terraform Version
-----------------

This module was created using Terraform 0.11.7. 
So to be more safe, Terraform version 0.11.7 or newer is required to use this module.

Authors
-------

* [Karsten Ari Agathon](https://github.com/karstenaa)

License
-------

Apache 2 Licensed. See LICENSE for full details.
