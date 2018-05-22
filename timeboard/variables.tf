variable "product_domain" {
  type        = "string"
  description = "The name of the product domain which this load balancer belongs to"
}

variable "lb_name" {
  type        = "string"
  description = "The name of the load balancer"
}

variable "lb_type" {
  type        = "string"
  description = "The type of the load balancer"
}
