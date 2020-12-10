# Configure the SignalFx provider
provider "signalfx" {
  auth_token = var.signalfx_auth_token
  # If your organization uses a different realm
  api_url = var.api_url
  # If your organization uses a custom URL
  # custom_app_url = "https://myorg.signalfx.com"
}

resource "signalfx_dashboard_group" "mydashboardgroup0" {
  name        = var.tf_team_dashboard_group
  description = var.tf_team_dashboard_group_description

  # Note that if you use these features, you must use a user's
  # admin key to authenticate the provider, lest Terraform not be able
  # to modify the dashboard group in the future!
  #authorized_writer_teams = [signalfx_team.mycoolteam.id]
  #authorized_writer_users = ["abc123"]
}

resource "signalfx_dashboard" "mydashboard0" {
  name            = var.tf_dashboard
  dashboard_group = signalfx_dashboard_group.mydashboardgroup0.id

  time_range = "-30m"

/*
  filter {
    property = "collector"
    values   = ["cpu", "Diamond"]
  }
*/
  variable {
    property = "host"
    alias    = "host"
    values   = ["SeanMacbook"]
  }
  chart {
    chart_id = signalfx_time_chart.mychart0.id
    width    = 12
    height   = 1
    row      = 1
    column   = 1
  }
  chart {
    chart_id = signalfx_time_chart.mychart1.id
    width    = 6
    height   = 1
    row      = 0
    column   = 0
  }
  chart {
    chart_id = signalfx_time_chart.mychart2.id
    width    = 6
    height   = 1
    row      = 0
    column   = 6
  }
}

resource "signalfx_time_chart" "mychart0" {
  name = "CPU Utilization"
  description = "CPU Utilization via Smart Agent"
  program_text = <<-EOF
        A = data("cpu.utilization").publish(label="CPU Utilization")
        EOF
  time_range = 3600
  plot_type         = "LineChart"
  show_data_markers = true
  legend_options_fields {
    property = "collector"
    enabled  = false
  }
  legend_options_fields {
    property = "hostname"
    enabled  = false
  }
  viz_options {
    label = "CPU Utilization"
    axis  = "left"
    color = "orange"
  }
  axis_left {
    label         = "CPU Utilization"
    low_watermark = 1000
  }
}

resource "signalfx_time_chart" "mychart1" {
  name = "IF Errors"
  description = "Network Interface Transmission Errors"
  program_text = <<-EOF
        A = data('if_errors.tx', filter=filter('plugin_instance', 'en0'), rollup='rate').publish(label='IF Errors')
        EOF
  time_range = 1800
  plot_type         = "LineChart"
  show_data_markers = true
  legend_options_fields {
    property = "collector"
    enabled  = false
  }
  legend_options_fields {
    property = "hostname"
    enabled  = false
  }
  viz_options {
    label = "IF Errors"
    axis  = "left"
    color = "green"
  }
  axis_left {
    label         = "IF Errors"
    low_watermark = 1000
  }
}

resource "signalfx_time_chart" "mychart2" {
  name = "Disk Octets"
  description = "No Idea What Disk Octets are? You're not alone"
  program_text = <<-EOF
        A = data('disk_octets.write', rollup='rate').publish(label='Disk Octets')
        EOF
  time_range = 1800
  plot_type         = "LineChart"
  show_data_markers = true
  legend_options_fields {
    property = "collector"
    enabled  = false
  }
  legend_options_fields {
    property = "hostname"
    enabled  = false
  }
  viz_options {
    label = "Disk Octets"
    axis  = "right"
    color = "blue"
  }
  axis_right {
    label         = "Disk Octets"
    low_watermark = 1000
  }
}

