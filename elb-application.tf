locals {
  elb_application_monitor_enabled = "${var.enabled && var.lb_type == "application" && length(var.recipients) > 0 ? 1 : 0}"
}

resource "datadog_timeboard" "elb_application" {
  count       = "${var.lb_type == "application" ? 1 : 0}"
  title       = "${var.product_domain} - ${var.lb_name} - ${var.environment} - ELB Application"
  description = "A generated timeboard for ELB Application"

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
      q    = "avg:aws.applicationelb.client_tlsnegotiation_error_count{$lb_name, $environment} by {name,availability-zone}"
      type = "line"
    }
  }

  graph {
    title     = "HTTP Responses Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.applicationelb.httpcode_elb_4xx{$lb_name, $environment} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.applicationelb.httpcode_elb_5xx{$lb_name, $environment} by {name,availability-zone}.as_count()"
      type = "line"
    }
  }

  graph {
    title     = "HTTP Target Responses Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.applicationelb.httpcode_target_2xx{$lb_name, $environment} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.applicationelb.httpcode_target_3xx{$lb_name, $environment} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.applicationelb.httpcode_target_4xx{$lb_name, $environment} by {name,availability-zone}.as_count()"
      type = "line"
    }

    request {
      q    = "avg:aws.applicationelb.httpcode_target_3xx{$lb_name, $environment} by {name,availability-zone}.as_count()"
      type = "line"
    }
  }

  graph {
    title     = "Request Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.applicationelb.request_count{$lb_name, $environment} by {name,availability-zone}.as_count()"
      type = "line"
    }
  }

  graph {
    title     = "Healthy Host Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "sum:aws.applicationelb.healthy_host_count{$lb_name, $environment} by {name,availability-zone}"
      type = "line"
    }

    request {
      q    = "sum:aws.applicationelb.healthy_host_count.maximum{$lb_name, $environment} by {name,availability-zone}"
      type = "line"
    }

    request {
      q    = "sum:aws.applicationelb.healthy_host_count.minimum{$lb_name, $environment} by {name,availability-zone}"
      type = "line"
    }

    request {
      q    = "sum:aws.applicationelb.healthy_host_count_deduped{$lb_name, $environment} by {name,availability-zone}"
      type = "line"
    }
  }

  graph {
    title     = "Unhealthy Host Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "sum:aws.applicationelb.un_healthy_host_count{$lb_name, $environment} by {name,availability-zone}"
      type = "line"
    }

    request {
      q    = "sum:aws.applicationelb.un_healthy_host_count.maximum{$lb_name, $environment} by {name,availability-zone}"
      type = "line"
    }

    request {
      q    = "sum:aws.applicationelb.un_healthy_host_count.minimum{$lb_name, $environment} by {name,availability-zone}"
      type = "line"
    }

    request {
      q    = "sum:aws.applicationelb.un_healthy_host_count_deduped{$lb_name, $environment} by {name,availability-zone}"
      type = "line"
    }
  }

  graph {
    title     = "Active Connection Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.applicationelb.active_connection_count{$lb_name, $environment} by {name}"
      type = "line"
    }
  }

  graph {
    title     = "New Connection Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.applicationelb.new_connection_count{$lb_name, $environment} by {name}.as_count()"
      type = "line"
    }
  }

  graph {
    title     = "Processed Bytes"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.applicationelb.processed_bytes{$lb_name, $environment} by {name}.as_count()"
      type = "line"
    }
  }

  graph {
    title     = "Consumed Lcus"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.applicationelb.consumed_lcus{$lb_name, $environment} by {name}"
      type = "line"
    }
  }
}

module "elb_application_monitor_healthy_host_count" {
  source  = "github.com/traveloka/terraform-datadog-monitor"
  enabled = "${local.elb_application_monitor_enabled}"

  product_domain = "${var.product_domain}"
  service        = "${var.service}"
  environment    = "${var.environment}"
  tags           = "${var.tags}"
  timeboard_id   = "${join(",", datadog_timeboard.elb_application.*.id)}"

  name               = "${var.product_domain} - ${var.lb_name} - ${var.environment} - Number of Healthy Hosts is Low"
  query              = "avg(last_10m):sum:aws.applicationelb.healthy_host_count{name:${var.lb_name}, environment:${var.environment}} by {name, availability-zone} <= ${var.healthy_host_count_thresholds["critical"]}"
  thresholds         = "${var.healthy_host_count_thresholds}"
  message            = "${var.healthy_host_count_message}"
  escalation_message = "${var.healthy_host_count_escalation_message}"

  recipients         = "${var.recipients}"
  alert_recipients   = "${var.alert_recipients}"
  warning_recipients = "${var.warning_recipients}"

  renotify_interval = "${var.renotify_interval}"
  notify_audit      = "${var.notify_audit}"
}
