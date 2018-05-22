resource "datadog_timeboard" "elb_classic" {
  count       = "${var.lb_type == "classic" ? 1 : 0}"
  title       = "${var.product_domain} - ${var.lb_name} - ELB Classic"
  description = "A generated timeboard for ELB Classic"

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
      q    = "avg:aws.elb.client_tlsnegotiation_error_count{$lb_name} by {name,availability-zone}"
      type = "line"
    }
  }

  graph {
    title     = "HTTP Backend Responses Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elb.httpcode_backend_2xx{$lb_name} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.elb.httpcode_backend_3xx{$lb_name} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.elb.httpcode_backend_4xx{$lb_name} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.elb.httpcode_backend_5xx{$lb_name} by {name,availability-zone}.as_count()"
      type = "line"
    }
  }

  graph {
    title     = "HTTP Target Responses Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elb.target_response_time.maximum{$lb_name} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.elb.target_response_time.average{$lb_name} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.elb.target_response_time.p95{$lb_name} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.elb.target_response_time.p99{$lb_name} by {name,availability-zone}.as_count()"
      type = "line"
    }
  }

  graph {
    title     = "Request Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elb.request_count{$lb_name} by {name,availability-zone}.as_count()"
      type = "line"
    }
  }

  graph {
    title     = "Healthy Host Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elb.healthy_host_count{$lb_name} by {name,availability-zone}"
      type = "line"
    }

    request {
      q    = "avg:aws.elb.healthy_host_count.maximum{$lb_name} by {name,availability-zone}"
      type = "line"
    }

    request {
      q    = "avg:aws.elb.healthy_host_count.minimum{$lb_name} by {name,availability-zone}"
      type = "line"
    }

    request {
      q    = "avg:aws.elb.healthy_host_count_deduped{$lb_name} by {name,availability-zone}"
      type = "line"
    }
  }

  graph {
    title     = "Unhealthy Host Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elb.un_healthy_host_count{$lb_name} by {name,availability-zone}"
      type = "line"
    }

    request {
      q    = "avg:aws.elb.un_healthy_host_count.maximum{$lb_name} by {name,availability-zone}"
      type = "line"
    }

    request {
      q    = "avg:aws.elb.un_healthy_host_count.minimum{$lb_name} by {name,availability-zone}"
      type = "line"
    }

    request {
      q    = "avg:aws.elb.un_healthy_host_count_deduped{$lb_name} by {name,availability-zone}"
      type = "line"
    }
  }

  graph {
    title     = "Latency"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elb.latency.p95{$lb_name} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.elb.latency.p99{$lb_name} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.elb.latency.maximum{$lb_name} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.elb.latency.minimum{$lb_name} by {name,availability-zone}.as_count()"
      type = "line"
    }
  }

  graph {
    title     = "Active Connection Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elb.estimated_albactive_connection_count{$lb_name} by {name}"
      type = "line"
    }
  }

  graph {
    title     = " Processed Bytes"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elb.estimated_processed_bytes{$lb_name} by {name}.as_count()"
      type = "line"
    }
  }

  graph {
    title     = "Consumed Lcus"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elb.estimated_albconsumed_lcus{$lb_name} by {name}"
      type = "line"
    }
  }

  graph {
    title     = "New Connection Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elb.estimated_albnew_connection_count{$lb_name} by {name}.as_count()"
      type = "line"
    }
  }

  graph {
    title     = "Backend Connection Error Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elb.estimated_albnew_connection_count{$lb_name} by {name}.as_count()"
      type = "line"
    }
  }

  graph {
    title     = "Surge Queue Length"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elb.surge_queue_length{$lb_name} by {name,availability-zone}"
      type = "line"
    }
  }
}
