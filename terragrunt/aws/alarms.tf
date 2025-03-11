locals {
  ecs_services = toset([
    module.superset_ecs,
    module.celery_beat_ecs,
    module.celery_worker_ecs
  ])

  superset_error_filters = [
    "CRITICAL", "ERROR"
  ]
  superset_error_filters_skip = [
    "'Template' object has no attribute 'strip'",
    "AccessDenied*GENERIC_DB_ENGINE_ERROR",
    "COLUMN_NOT_FOUND",
    "contains non-numeric values",
    "DML_NOT_ALLOWED_ERROR",
    "Error on OAuth authorize",
    "Error warming up cache",
    "Failed to execute query",
    "gsheets error: Unsupported format",
    "Insufficient permissions to execute the query",
    "Only `SELECT` statements are allowed",
    "SYNTAX_ERROR",
    "TABLE_DOES_NOT_EXIST_ERROR"
  ]
  superset_error_metric_pattern = "[(w1=\"*${join("*\" || w1=\"*", local.superset_error_filters)}*\") && w1!=\"*${join("*\" && w1!=\"*", local.superset_error_filters_skip)}*\"]"


  superset_warning_filters = [
    "Error warming up cache"
  ]
  superset_warning_metric_pattern = "[(w1=\"*${join("*\" || w1=\"*", local.superset_warning_filters)}*\")]"

  threshold_ecs_high_cpu     = 80
  threshold_ecs_high_memory  = 80
  threshold_lb_response_time = 2
}

#
# ECS resource use
#
resource "aws_cloudwatch_metric_alarm" "superset_ecs_high_cpu" {
  for_each = { for service in local.ecs_services : service.service_name => service }

  alarm_name          = "ecs-${each.key}-high-cpu"
  alarm_description   = "`${each.key}` high CPU use over 5 minutes."
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "5"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = local.threshold_ecs_high_cpu
  treat_missing_data  = "notBreaching"

  alarm_actions = [aws_sns_topic.cloudwatch_alert_warning.arn]
  ok_actions    = [aws_sns_topic.cloudwatch_alert_ok.arn]

  dimensions = {
    ClusterName = module.superset_ecs.cluster_name
    ServiceName = each.key
  }

  tags = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "superset_ecs_high_memory" {
  for_each = { for service in local.ecs_services : service.service_name => service }

  alarm_name          = "ecs-${each.key}-high-memory"
  alarm_description   = "`${each.key}` high memory use over 5 minutes."
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "5"
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = local.threshold_ecs_high_memory
  treat_missing_data  = "notBreaching"

  alarm_actions = [aws_sns_topic.cloudwatch_alert_warning.arn]
  ok_actions    = [aws_sns_topic.cloudwatch_alert_ok.arn]

  dimensions = {
    ClusterName = module.superset_ecs.cluster_name
    ServiceName = each.key
  }

  tags = local.common_tags
}

#
# Load balancer
#
resource "aws_cloudwatch_metric_alarm" "superset_load_balancer_unhealthy_hosts" {
  alarm_name          = "load-balancer-unhealthy-hosts"
  alarm_description   = "There are unhealthy Superset load balancer hosts in a 1 minute period."
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = "1"
  evaluation_periods  = "1"
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Maximum"
  treat_missing_data  = "notBreaching"

  alarm_actions = [aws_sns_topic.cloudwatch_alert_warning.arn]
  ok_actions    = [aws_sns_topic.cloudwatch_alert_ok.arn]

  dimensions = {
    LoadBalancer = aws_lb.superset.arn_suffix
    TargetGroup  = aws_lb_target_group.superset.arn_suffix
  }

  tags = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "superset_load_balancer_healthy_hosts" {
  alarm_name          = "load-balancer-healthy-hosts"
  alarm_description   = "There are no healthy hosts for the Superset load balancer in a 1 minute period."
  comparison_operator = "LessThanThreshold"
  threshold           = "1"
  evaluation_periods  = "1"
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Maximum"
  treat_missing_data  = "notBreaching"

  alarm_actions = [aws_sns_topic.cloudwatch_alert_warning.arn]
  ok_actions    = [aws_sns_topic.cloudwatch_alert_ok.arn]

  dimensions = {
    LoadBalancer = aws_lb.superset.arn_suffix
    TargetGroup  = aws_lb_target_group.superset.arn_suffix
  }

  tags = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "superset_load_balancer_response_time" {
  alarm_name          = "load-balancer-response-time"
  alarm_description   = "Response time for the Superset load balancer is greater than 2 seconds over 5 minutes."
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "3"
  threshold           = local.threshold_lb_response_time
  treat_missing_data  = "notBreaching"

  alarm_actions = [aws_sns_topic.cloudwatch_alert_warning.arn]
  ok_actions    = [aws_sns_topic.cloudwatch_alert_ok.arn]

  metric_query {
    id          = "response_time"
    return_data = "true"
    metric {
      metric_name = "TargetResponseTime"
      namespace   = "AWS/ApplicationELB"
      period      = "60"
      stat        = "Average"
      dimensions = {
        LoadBalancer = aws_lb.superset.arn_suffix
        TargetGroup  = aws_lb_target_group.superset.arn_suffix
      }
    }
  }

  tags = local.common_tags
}

#
# Warnings logged
#
resource "aws_cloudwatch_log_metric_filter" "superset_ecs_warnings" {
  for_each = { for service in local.ecs_services : service.service_name => service }

  name           = "${each.key}-warning"
  pattern        = local.superset_warning_metric_pattern
  log_group_name = each.value.cloudwatch_log_group_name

  metric_transformation {
    name          = "${each.key}-warning"
    namespace     = "superset"
    value         = "1"
    default_value = "0"
  }
}

resource "aws_cloudwatch_metric_alarm" "superset_ecs_warnings" {
  for_each = { for service in local.ecs_services : service.service_name => service }

  alarm_name          = "warnings-${each.key}"
  alarm_description   = "`${each.key}` warnings logged over 1 day."
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = aws_cloudwatch_log_metric_filter.superset_ecs_warnings[each.key].metric_transformation[0].name
  namespace           = aws_cloudwatch_log_metric_filter.superset_ecs_warnings[each.key].metric_transformation[0].namespace
  period              = "86400" # 1 day
  statistic           = "Sum"
  threshold           = "3"
  treat_missing_data  = "notBreaching"

  alarm_actions = [aws_sns_topic.cloudwatch_alert_warning.arn]
  ok_actions    = [aws_sns_topic.cloudwatch_alert_ok.arn]

  tags = local.common_tags
}

#
# Errors logged
#
resource "aws_cloudwatch_log_metric_filter" "superset_ecs_errors" {
  for_each = { for service in local.ecs_services : service.service_name => service }

  name           = "${each.key}-error"
  pattern        = local.superset_error_metric_pattern
  log_group_name = each.value.cloudwatch_log_group_name

  metric_transformation {
    name          = "${each.key}-error"
    namespace     = "superset"
    value         = "1"
    default_value = "0"
  }
}

resource "aws_cloudwatch_metric_alarm" "superset_ecs_errors" {
  for_each = { for service in local.ecs_services : service.service_name => service }

  alarm_name          = "errors-${each.key}"
  alarm_description   = "`${each.key}` errors logged over 1 minute."
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = aws_cloudwatch_log_metric_filter.superset_ecs_errors[each.key].metric_transformation[0].name
  namespace           = aws_cloudwatch_log_metric_filter.superset_ecs_errors[each.key].metric_transformation[0].namespace
  period              = "60"
  statistic           = "Sum"
  threshold           = "0"
  treat_missing_data  = "notBreaching"

  alarm_actions = [aws_sns_topic.cloudwatch_alert_warning.arn]
  ok_actions    = [aws_sns_topic.cloudwatch_alert_ok.arn]

  tags = local.common_tags
}

#
# Log Insight queries
#
resource "aws_cloudwatch_query_definition" "superset_ecs_errors" {
  name = "Superset - errors"

  log_group_names = [for service in local.ecs_services : service.cloudwatch_log_group_name]

  query_string = <<-QUERY
    fields @timestamp, @message, @logStream
    | filter @message like /${join("|", local.superset_error_filters)}/
    | sort @timestamp desc
    | limit 100
  QUERY
}