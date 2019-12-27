variable "enabled" {
  type        = "string"
  default     = true
  description = "To enable this module"
}

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

variable "environment" {
  type        = "string"
  default     = "*"
  description = "The name of the environment"
}

variable "tags" {
  type        = "list"
  default     = []
  description = "Additional tags for monitors"
}

variable "recipients" {
  type        = "list"
  default     = []
  description = "Notification recipients when both alert and warning are triggered"
}

variable "alert_recipients" {
  type        = "list"
  default     = []
  description = "Notification recipients when only alert is triggered"
}

variable "warning_recipients" {
  type        = "list"
  default     = []
  description = "Notification recipients when only warning is triggered"
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

variable "healthy_host_name" {
  type        = "string"
  default     = ""
  description = "The name for ELB Healthy Host Count Monitor, else use default"
}

variable "healthy_host_count_thresholds" {
  type = "map"

  default = {
    critical = 0
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

variable "healthy_host_include_tags" {
  type        = "string"
  default     = true
  description = "The flag to include tags in name for ELB Healthy Host Count Monitor"
}