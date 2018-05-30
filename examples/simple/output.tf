output "timeboard_title" {
  value = "${module.elb.timeboard_title}"
}

output "monitor_healthy_host_count_name" {
  value = "${module.elb.monitor_healthy_host_count_name}"
}
