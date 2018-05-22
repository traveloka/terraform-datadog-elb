locals {
  enabled_elb_application = "${var.enabled && var.lb_type == "application" ? 1 : 0}"
}

module "elb_application_healthy_host_count" {
  source  = "github.com/traveloka/terraform-datadog-monitor"
  enabled = "${local.enabled_elb_application}"

  product_domain = "${var.product_domain}"
  service        = "${var.service}"

  name               = "${var.product_domain} - ${var.lb_name} - Number of Healthy Hosts is Low"
  query              = "avg(last_5m):sum:aws.applicationelb.healthy_host_count{name:${var.lb_name}} by {name}"
  thresholds         = "${var.healthy_host_count_thresholds}"
  message            = "${var.healthy_host_count_message}"
  escalation_message = "${var.healthy_host_count_escalation_message}"

  recipients = "${var.recipients}"

  renotify_interval = "${var.renotify_interval}"
  notify_audit      = "${var.notify_audit}"
}
