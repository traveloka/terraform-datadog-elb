resource "datadog_timeboard" "elb_application" {
  count       = "${var.lb_type == "application" ? 1 : 0}"
  title       = "${var.product_domain} - ${var.lb_name} - ELB Application"
  description = "A generated timeboard for ELB Application"

  template_variable {
    default = "${var.lb_name}"
    name    = "lb_name"
    prefix  = "name"
  }

  graph {
    title     = "Client TLS Negotiation Error Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.applicationelb.client_tlsnegotiation_error_count{$lb_name} by {name,availability-zone}"
      type = "line"
    }
  }

  graph {
    title     = "HTTP Responses Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.applicationelb.httpcode_elb_4xx{$lb_name} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.applicationelb.httpcode_elb_5xx{$lb_name} by {name,availability-zone}.as_count()"
      type = "line"
    }
  }

  graph {
    title     = "HTTP Target Responses Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.applicationelb.httpcode_target_2xx{$lb_name} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.applicationelb.httpcode_target_3xx{$lb_name} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.applicationelb.httpcode_target_4xx{$lb_name} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.applicationelb.httpcode_target_3xx{$lb_name} by {name,availability-zone}.as_count()"
      type = "line"
    }
  }

  graph {
    title     = "Request Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.applicationelb.request_count{$lb_name} by {name,availability-zone}.as_count()"
      type = "line"
    }
  }

  graph {
    title     = "Healthy Host Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.applicationelb.healthy_host_count{$lb_name} by {name,availability-zone}"
      type = "line"
    }

    request {
      q    = "avg:aws.applicationelb.healthy_host_count.maximum{$lb_name} by {name,availability-zone}"
      type = "line"
    }

    request {
      q    = "avg:aws.applicationelb.healthy_host_count.minimum{$lb_name} by {name,availability-zone}"
      type = "line"
    }

    request {
      q    = "avg:aws.applicationelb.healthy_host_count_deduped{$lb_name} by {name,availability-zone}"
      type = "line"
    }
  }

  graph {
    title     = "Unhealthy Host Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.applicationelb.un_healthy_host_count{$lb_name} by {name,availability-zone}"
      type = "line"
    }

    request {
      q    = "avg:aws.applicationelb.un_healthy_host_count.maximum{$lb_name} by {name,availability-zone}"
      type = "line"
    }

    request {
      q    = "avg:aws.applicationelb.un_healthy_host_count.minimum{$lb_name} by {name,availability-zone}"
      type = "line"
    }

    request {
      q    = "avg:aws.applicationelb.un_healthy_host_count_deduped{$lb_name} by {name,availability-zone}"
      type = "line"
    }
  }

  graph {
    title     = "Active Connection Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.applicationelb.active_connection_count{$lb_name} by {name}"
      type = "line"
    }
  }

  graph {
    title     = "New Connection Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.applicationelb.new_connection_count{$lb_name} by {name}.as_count()"
      type = "line"
    }
  }

  graph {
    title     = "Processed Bytes"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.applicationelb.processed_bytes{$lb_name} by {name}.as_count()"
      type = "line"
    }
  }

  graph {
    title     = "Consumed Lcus"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.applicationelb.consumed_lcus{$lb_name} by {name}"
      type = "line"
    }
  }
}
