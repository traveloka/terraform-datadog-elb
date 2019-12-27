module "elb" {
  source         = "../../"
  product_domain = "BEI"
  service        = "beical"
  lb_name        = "beical-lbint"
  lb_type        = "application"
  environment    = "production"
  tags           = ["tag1", "tag2"]

  recipients         = ["bei@traveloka.com"]
  alert_recipients   = ["pagerduty-bei"]
  warning_recipients = ["slack-bei"]
  renotify_interval  = 0
  notify_audit       = false

  healthy_host_name = "Healthy Host Name"
  healthy_host_count_thresholds = {
    critical = 0
    warning  = 1
  }

  healthy_host_count_message            = "Monitor is triggered"
  healthy_host_count_escalation_message = "Monitor isn't resolved for given interval"
  healthy_host_include_tags             = false
}
