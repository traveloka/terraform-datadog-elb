output "title" {
  value       = "${var.lb_type == "application" ? join(",", datadog_timeboard.elb_application.*.title) : join(",", datadog_timeboard.elb_classic.*.title)}"
  description = "The title of datadog timeboard for ELB"
}
