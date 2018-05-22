variable "product_domain" {
  type        = "string"
  description = "The name of the product domain"
}

variable "service" {
  type        = "string"
  description = "The name of the service"
}

variable "lb_name" {
  type        = "string"
  description = "The name of the load balancer"
}

variable "lb_type" {
  type        = "string"
  description = "The type of the load balancer"
}

variable "healthy_host_count_thresholds" {
  type = "map"

  default = {
    critical = 0
    warning  = 1
  }

  description = "The warning and critical thresholds for ELB Healthy Host Count monitoring"
}

variable "healthy_host_count_message" {
  type        = "string"
  default     = ""
  description = "The message when ELB Healthy Host Count triggered"
}

variable "healthy_host_count_escalation_message" {
  type        = "string"
  default     = ""
  description = "The escalation message when ELB Healthy Host Count monitor isn't resolved for given time"
}

variable "recipients" {
  type        = "list"
  default     = []
  description = "Notification recipients when monitor triggered"
}

variable "renotify_interval" {
  type        = "string"
  default     = "0"
  description = "Time interval in minutes which escalation_message will be sent when monitor is triggered"
}

variable "notify_audit" {
  type        = "string"
  default     = false
  description = "Whether any configuration changes should be notified"
}

variable "enabled" {
  type        = "string"
  default     = true
  description = "To enable this module"
}
