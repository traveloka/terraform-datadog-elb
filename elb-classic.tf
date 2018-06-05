locals {
  elb_classic_monitor_enabled = "${var.enabled && var.lb_type == "classic" && length(var.recipients) > 0 ? 1 : 0}"
}

resource "datadog_timeboard" "elb_classic" {
  count       = "${var.lb_type == "classic" ? 1 : 0}"
  title       = "${var.product_domain} - ${var.lb_name} - ${var.environment} - ELB Classic"
  description = "A generated timeboard for ELB Classic"

  template_variable {
    default = "${var.lb_name}"
    name    = "lb_name"
    prefix  = "name"
  }

  template_variable {
    default = "${var.environment}"
    name    = "environment"
    prefix  = "environment"
  }

  graph {
    title     = "Client TLS Negotiation Error Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elb.client_tlsnegotiation_error_count{$lb_name, $environment} by {name,availability-zone}"
      type = "line"
    }
  }

  graph {
    title     = "HTTP Backend Responses Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elb.httpcode_backend_2xx{$lb_name, $environment} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.elb.httpcode_backend_3xx{$lb_name, $environment} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.elb.httpcode_backend_4xx{$lb_name, $environment} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.elb.httpcode_backend_5xx{$lb_name, $environment} by {name,availability-zone}.as_count()"
      type = "line"
    }
  }

  graph {
    title     = "HTTP Target Responses Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elb.target_response_time.maximum{$lb_name, $environment} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.elb.target_response_time.average{$lb_name, $environment} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.elb.target_response_time.p95{$lb_name, $environment} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.elb.target_response_time.p99{$lb_name, $environment} by {name,availability-zone}.as_count()"
      type = "line"
    }
  }

  graph {
    title     = "Request Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elb.request_count{$lb_name, $environment} by {name,availability-zone}.as_count()"
      type = "line"
    }
  }

  graph {
    title     = "Healthy Host Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "sum:aws.elb.healthy_host_count{$lb_name, $environment} by {name,availability-zone}"
      type = "line"
    }

    request {
      q    = "sum:aws.elb.healthy_host_count.maximum{$lb_name, $environment} by {name,availability-zone}"
      type = "line"
    }

    request {
      q    = "sum:aws.elb.healthy_host_count.minimum{$lb_name, $environment} by {name,availability-zone}"
      type = "line"
    }

    request {
      q    = "sum:aws.elb.healthy_host_count_deduped{$lb_name, $environment} by {name,availability-zone}"
      type = "line"
    }
  }

  graph {
    title     = "Unhealthy Host Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "sum:aws.elb.un_healthy_host_count{$lb_name, $environment} by {name,availability-zone}"
      type = "line"
    }

    request {
      q    = "sum:aws.elb.un_healthy_host_count.maximum{$lb_name, $environment} by {name,availability-zone}"
      type = "line"
    }

    request {
      q    = "sum:aws.elb.un_healthy_host_count.minimum{$lb_name, $environment} by {name,availability-zone}"
      type = "line"
    }

    request {
      q    = "sum:aws.elb.un_healthy_host_count_deduped{$lb_name, $environment} by {name,availability-zone}"
      type = "line"
    }
  }

  graph {
    title     = "Latency"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elb.latency.p95{$lb_name, $environment} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.elb.latency.p99{$lb_name, $environment} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.elb.latency.maximum{$lb_name, $environment} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.elb.latency.minimum{$lb_name, $environment} by {name,availability-zone}.as_count()"
      type = "line"
    }
  }

  graph {
    title     = "Active Connection Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elb.estimated_albactive_connection_count{$lb_name, $environment} by {name}"
      type = "line"
    }
  }

  graph {
    title     = " Processed Bytes"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elb.estimated_processed_bytes{$lb_name, $environment} by {name}.as_count()"
      type = "line"
    }
  }

  graph {
    title     = "Consumed Lcus"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elb.estimated_albconsumed_lcus{$lb_name, $environment} by {name}"
      type = "line"
    }
  }

  graph {
    title     = "New Connection Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elb.estimated_albnew_connection_count{$lb_name, $environment} by {name}.as_count()"
      type = "line"
    }
  }

  graph {
    title     = "Backend Connection Error Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elb.estimated_albnew_connection_count{$lb_name, $environment} by {name}.as_count()"
      type = "line"
    }
  }

  graph {
    title     = "Surge Queue Length"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elb.surge_queue_length{$lb_name, $environment} by {name,availability-zone}"
      type = "line"
    }
  }
}

module "elb_classic_monitor_healthy_host_count" {
  source  = "github.com/traveloka/terraform-datadog-monitor"
  enabled = "${local.elb_classic_monitor_enabled}"

  product_domain = "${var.product_domain}"
  service        = "${var.service}"
  environment    = "${var.environment}"
  tags           = "${var.tags}"
  timeboard_id   = "${join(",", datadog_timeboard.elb_classic.*.id)}"

  name               = "${var.product_domain} - ${var.lb_name} - ${var.environment} - Number of Healthy Hosts is Low"
  query              = "avg(last_10m):sum:aws.elb.healthy_host_count{name:${var.lb_name}, environment:${var.environment}} by {name, availability-zone} <= ${var.healthy_host_count_thresholds["critical"]}"
  thresholds         = "${var.healthy_host_count_thresholds}"
  message            = "${var.healthy_host_count_message}"
  escalation_message = "${var.healthy_host_count_escalation_message}"

  recipients         = "${var.recipients}"
  alert_recipients   = "${var.alert_recipients}"
  warning_recipients = "${var.warning_recipients}"

  renotify_interval = "${var.renotify_interval}"
  notify_audit      = "${var.notify_audit}"
}
