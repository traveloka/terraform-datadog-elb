module "elb" {
  source         = "../../"
  product_domain = "BEI"
  service        = "beical"
  lb_name        = "beical-lbint"
  lb_type        = "application"
  environment    = "production"

  recipients = ["slack-bei", "pagerduty-bei", "bei@traveloka.com"]
}
