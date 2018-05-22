module "beical_lbint_monitor_elb" {
  source         = "../../"
  product_domain = "BEI"
  service        = "beical"
  lb_name        = "beical-lbint"
  lb_type        = "application"

  recipients = ["slack-bei", "pagerduty-bei", "bei@traveloka.com"]
}
