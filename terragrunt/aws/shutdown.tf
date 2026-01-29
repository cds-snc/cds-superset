module "schedule_shutdown" {
  count = var.env == "staging" ? 1 : 0

  source = "github.com/cds-snc/terraform-modules//schedule_shutdown?ref=v10.10.2"

  cloudwatch_alarm_arns = [
    aws_cloudwatch_metric_alarm.superset_load_balancer_unhealthy_hosts.arn,
    aws_cloudwatch_metric_alarm.superset_load_balancer_healthy_hosts.arn,
    aws_cloudwatch_metric_alarm.superset_load_balancer_response_time.arn,
  ]
  ecs_service_arns = [
    module.superset_ecs.service_id,
    module.celery_worker_ecs.service_id,
    module.celery_beat_ecs.service_id,
  ]

  schedule_shutdown = "cron(0 22 * * ? *)"       # 10pm UTC, every day
  schedule_startup  = "cron(0 10 ? * MON-FRI *)" # 10am UTC, Monday-Friday

  billing_tag_value = var.billing_tag_value
}
