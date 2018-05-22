locals {
  enabled_elb_classic = "${var.enabled && var.lb_type == "classic" ? 1 : 0}"
}

module "elb_classic_healthy_host_count" {
  source  = "github.com/traveloka/terraform-datadog-monitor?ref=v0.1.3"
  enabled = "${local.enabled_elb_classic}"

  product_domain = "${var.product_domain}"
  service        = "${var.service}"

  name               = "${var.product_domain} - ${var.lb_name} - Number of Healthy Hosts is Low"
  query              = "avg(last_5m):sum:aws.elb.healthy_host_count{name:${var.lb_name}} by {name}"
  thresholds         = "${var.healthy_host_count_thresholds}"
  message            = "${var.healthy_host_count_message}"
  escalation_message = "${var.healthy_host_count_escalation_message}"

  recipients = "${var.recipients}"

  renotify_interval = "${var.renotify_interval}"
  notify_audit      = "${var.notify_audit}"
}
