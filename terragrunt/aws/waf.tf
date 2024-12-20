locals {
  excluded_common_rules    = ["SizeRestrictions_BODY"]
  cbs_satellite_bucket_arn = "arn:aws:s3:::${var.cbs_satellite_bucket_name}"
}

#
# Load balancer WAF ACL
#
resource "aws_wafv2_web_acl" "superset" {
  name  = "superset_lb"
  scope = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "InvalidHost"
    priority = 1

    action {
      block {}
    }

    statement {
      not_statement {
        statement {
          byte_match_statement {
            field_to_match {
              single_header {
                name = "host"
              }
            }
            text_transformation {
              priority = 1
              type     = "COMPRESS_WHITE_SPACE"
            }
            text_transformation {
              priority = 2
              type     = "LOWERCASE"
            }
            positional_constraint = "EXACTLY"
            search_string         = var.domain
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "InvalidHost"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSManagedRulesAmazonIpReputationList"
    priority = 10

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesAmazonIpReputationList"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "RateLimitersRuleGroup"
    priority = 20

    override_action {
      none {}
    }

    statement {
      rule_group_reference_statement {
        arn = aws_wafv2_rule_group.rate_limiters_group.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "rate_limiters_rule_group"
      sampled_requests_enabled   = false
    }
  }

  rule {
    name     = "AWSManagedRulesKnownBadInputsRuleSet"
    priority = 30
    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesKnownBadInputsRuleSet"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSManagedRulesLinuxRuleSet"
    priority = 40
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesLinuxRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesLinuxRuleSet"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 50

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        dynamic "rule_action_override" {
          for_each = local.excluded_common_rules
          content {
            name = rule_action_override.value
            action_to_use {
              count {}
            }
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesCommonRuleSet"
      sampled_requests_enabled   = true
    }
  }

  # Label match rule
  # Blocks requests that trigger `AWSManagedRulesCommonRuleSet#SizeRestrictions_BODY` except those saving a dashboard
  rule {
    name     = "Label_SizeRestrictions_BODY"
    priority = 55

    action {
      block {}
    }

    statement {
      and_statement {
        statement {
          label_match_statement {
            scope = "LABEL"
            key   = "awswaf:managed:aws:core-rule-set:SizeRestrictions_Body"
          }
        }
        statement {
          not_statement {
            statement {
              and_statement {
                statement {
                  byte_match_statement {
                    field_to_match {
                      method {}
                    }
                    positional_constraint = "EXACTLY"
                    search_string         = "put"
                    text_transformation {
                      type     = "LOWERCASE"
                      priority = 0
                    }
                  }
                }
                statement {
                  byte_match_statement {
                    field_to_match {
                      uri_path {}
                    }
                    positional_constraint = "CONTAINS"
                    search_string         = "/api/v1/dashboard"
                    text_transformation {
                      type     = "LOWERCASE"
                      priority = 0
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Label_SizeRestrictions_BODY"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "BlockedIPv4"
    priority = 60

    action {
      count {}
    }

    statement {
      ip_set_reference_statement {
        arn = module.waf_ip_blocklist.ipv4_blocklist_arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "BlockedIPv4"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "superset"
    sampled_requests_enabled   = true
  }

  tags = local.common_tags
}

resource "aws_wafv2_rule_group" "rate_limiters_group" {
  capacity = 32
  name     = "RateLimitersGroup"
  scope    = "REGIONAL"

  rule {
    name     = "BlanketRequestLimit"
    priority = 1

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 1000
        aggregate_key_type = "IP"

      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "BlanketRequestLimit"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "PostRequestLimit"
    priority = 2

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 100
        aggregate_key_type = "IP"
        scope_down_statement {
          byte_match_statement {
            positional_constraint = "EXACTLY"
            field_to_match {
              method {}
            }
            search_string = "post"
            text_transformation {
              priority = 1
              type     = "LOWERCASE"
            }
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "PostRequestRateLimit"
      sampled_requests_enabled   = true
    }
  }
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "RateLimitersGroup"
    sampled_requests_enabled   = false
  }

  tags = local.common_tags
}

resource "aws_wafv2_web_acl_association" "superset" {
  resource_arn = aws_lb.superset.arn
  web_acl_arn  = aws_wafv2_web_acl.superset.arn
}

#
# WAF logging
#
resource "aws_wafv2_web_acl_logging_configuration" "superset_waf_logs" {
  log_destination_configs = [aws_kinesis_firehose_delivery_stream.superset_waf_logs.arn]
  resource_arn            = aws_wafv2_web_acl.superset.arn
}

resource "aws_kinesis_firehose_delivery_stream" "superset_waf_logs" {
  # checkov:skip=CKV_AWS_241: Encryption using CMK not required
  name        = "aws-waf-logs-superset"
  destination = "extended_s3"

  server_side_encryption {
    enabled = true
  }

  extended_s3_configuration {
    role_arn           = aws_iam_role.superset_waf_logs.arn
    prefix             = "waf_acl_logs/AWSLogs/${var.account_id}/"
    bucket_arn         = local.cbs_satellite_bucket_arn
    compression_format = "GZIP"
  }
}

#
# WAF logging IAM role
#
resource "aws_iam_role" "superset_waf_logs" {
  name               = "superset-waf-logs"
  assume_role_policy = data.aws_iam_policy_document.superset_waf_logs_assume.json
}

resource "aws_iam_role_policy" "superset_waf_logs" {
  name   = "superset-waf-logs"
  role   = aws_iam_role.superset_waf_logs.id
  policy = data.aws_iam_policy_document.superset_waf_logs.json
}

data "aws_iam_policy_document" "superset_waf_logs_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "superset_waf_logs" {
  statement {
    effect = "Allow"
    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject"
    ]
    resources = [
      local.cbs_satellite_bucket_arn,
      "${local.cbs_satellite_bucket_arn}/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "iam:CreateServiceLinkedRole"
    ]
    resources = [
      "arn:aws:iam::*:role/aws-service-role/wafv2.amazonaws.com/AWSServiceRoleForWAFV2Logging"
    ]
  }
}

#
# IPv4 blocklist that is automatically managed by a Lambda function.  Any IP address in the WAF logs
# that crosses a block threshold will be added to the blocklist.
#
module "waf_ip_blocklist" {
  source = "github.com/cds-snc/terraform-modules//waf_ip_blocklist?ref=v10.2.0"

  service_name                = "superset"
  athena_database_name        = "access_logs"
  athena_query_results_bucket = module.athena_bucket.s3_bucket_id
  athena_query_source_bucket  = var.cbs_satellite_bucket_name
  athena_lb_table_name        = "lb_logs"
  athena_waf_table_name       = "waf_logs"
  athena_workgroup_name       = "primary"

  billing_tag_value = var.billing_code
}