output "healthy_host_count_name" {
  value = "${var.lb_type == "application" 
  ? module.elb_application_healthy_host_count.name 
  : module.elb_classic_healthy_host_count.name}"

  description = "The name of datadog monitor for ELB Healthy Host Count"
}
