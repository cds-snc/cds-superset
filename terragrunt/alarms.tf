locals {
  ecs_services = toset([
    module.superset_ecs,
    module.celery_beat_ecs,
    module.celery_worker_ecs
  ])

  superset_error_filters = [
    "ERROR",
  ]
  superset_error_filters_skip = [
    "Error on OAuth authorize"
  ]
  superset_error_metric_pattern = "[(w1=\"*${join("*\" || w1=\"*", local.superset_error_filters)}*\") && w1!=\"*${join("*\" && w1!=\"*", local.superset_error_filters_skip)}*\"]"

  threshold_ecs_high_cpu     = 50
  threshold_ecs_high_memory  = 50
  threshold_lb_response_time = 1
}

#
# ECS resource use
#
resource "aws_cloudwatch_metric_alarm" "superset_ecs_high_cpu" {
  for_each = { for service in local.ecs_services : service.service_name => service }

  alarm_name          = "ecs-${each.key}-high-cpu"
  alarm_description   = ":warning: ${each.key} high CPU use over 2 minutes."
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "120"
  statistic           = "Maximum"
  threshold           = local.threshold_ecs_high_cpu
  treat_missing_data  = "notBreaching"

  alarm_actions = [aws_sns_topic.cloudwatch_alert_warning.arn]
  ok_actions    = [aws_sns_topic.cloudwatch_alert_ok.arn]

  dimensions = {
    ClusterName = module.superset_ecs.cluster_name
    ServiceName = each.key
  }
}

resource "aws_cloudwatch_metric_alarm" "superset_ecs_high_memory" {
  for_each = { for service in local.ecs_services : service.service_name => service }

  alarm_name          = "ecs-${each.key}-high-memory"
  alarm_description   = ":warning: ${each.key} high memory use over 2 minutes."
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = "120"
  statistic           = "Maximum"
  threshold           = local.threshold_ecs_high_memory
  treat_missing_data  = "notBreaching"

  alarm_actions = [aws_sns_topic.cloudwatch_alert_warning.arn]
  ok_actions    = [aws_sns_topic.cloudwatch_alert_ok.arn]

  dimensions = {
    ClusterName = module.superset_ecs.cluster_name
    ServiceName = each.key
  }
}

#
# Load balancer
#
resource "aws_cloudwatch_metric_alarm" "superset_load_balancer_unhealthy_hosts" {
  alarm_name          = "load-balancer-unhealthy-hosts"
  alarm_description   = ":warning: there are unhealthy Superset load balancer hosts in a 1 minute period."
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
}

resource "aws_cloudwatch_metric_alarm" "superset_load_balancer_healthy_hosts" {
  alarm_name          = "load-balancer-healthy-hosts"
  alarm_description   = ":dumpster-fire: there are no healthy hosts for the Superset load balance in a 1 minute period."
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
}

resource "aws_cloudwatch_metric_alarm" "superset_load_balancer_response_time" {
  alarm_name          = "load-balancer-response-time"
  alarm_description   = ":warning: response time for the Superset load balancer is greater than 1 second over 5 minutes."
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "5"
  datapoints_to_alarm = "2"
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
  alarm_description   = ":warning: ${each.key} errors logged over 1 minute."
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
}

#
# Log Insight queries
#
resource "aws_cloudwatch_query_definition" "superset_ecs_errors" {
  name = "Superset - errors"

  log_group_names = [for service in local.ecs_services : service.cloudwatch_log_group_name]

  query_string = <<-QUERY
    fields @timestamp, @message, @logStream
    | filter @message like /ERROR/
    | sort @timestamp desc
    | limit 100
  QUERY
}