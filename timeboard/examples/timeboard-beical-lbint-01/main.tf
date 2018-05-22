module "timeboard_elb_beical-lbint-01" {
  source         = "../../"
  product_domain = "BEI"
  lb_name        = "beical-lbint-01"
  lb_type        = "application"
}
