module "beical_lbint_monitor_elb" {
  source         = "../../"
  product_domain = "BEI"
  service        = "beical"
  lb_name        = "beical-lbint"
  lb_type        = "application"

  recipients        = ["slack-bei", "pagerduty-bei", "bei@traveloka.com"]
  renotify_interval = 0
  notify_audit      = false

  healthy_host_count_thresholds = {
    critical = 0
    warning  = 1
  }

  healthy_host_count_message            = "Monitor is triggered"
  healthy_host_count_escalation_message = "Monitor isn't resolved for given interval"
}
