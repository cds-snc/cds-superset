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
    name     = "CanadaOnlyGeoRestriction"
    priority = 5

    action {
      block {
        custom_response {
          response_code = 403
          response_header {
            name  = "waf-block"
            value = "CanadaOnlyGeoRestriction"
          }
        }
      }
    }

    statement {
      not_statement {
        statement {
          or_statement {
            statement {
              geo_match_statement {
                country_codes = ["CA"]
              }
            }
            statement {
              byte_match_statement {
                positional_constraint = "EXACTLY"
                field_to_match {
                  single_header {
                    name = "upptime"
                  }
                }
                search_string = var.upptime_status_header
                text_transformation {
                  priority = 1
                  type     = "NONE"
                }
              }
            }
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "CanadaOnlyGeoRestriction"
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
    name     = "RateLimitAllRequests"
    priority = 20

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 1500
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "RateLimitAllRequests"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "RateLimitMutatingRequests"
    priority = 25

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 200
        aggregate_key_type = "IP"
        scope_down_statement {
          regex_match_statement {
            field_to_match {
              method {}
            }
            regex_string = "^(delete|patch|post|put)$"
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
      metric_name                = "RateLimitMutatingRequests"
      sampled_requests_enabled   = true
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
                  regex_match_statement {
                    field_to_match {
                      method {}
                    }
                    regex_string = "^(put|post)$"
                    text_transformation {
                      type     = "LOWERCASE"
                      priority = 0
                    }
                  }
                }
                statement {
                  regex_pattern_set_reference_statement {
                    field_to_match {
                      uri_path {}
                    }
                    arn = aws_wafv2_regex_pattern_set.label_sizerestrictions_body_excluded_paths.arn
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
    name     = "AWSManagedRulesAntiDDoSRuleSet"
    priority = 60
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAntiDDoSRuleSet"
        vendor_name = "AWS"

        managed_rule_group_configs {
          aws_managed_rules_anti_ddos_rule_set {
            client_side_action_config {
              challenge {
                sensitivity     = "HIGH"
                usage_of_action = "ENABLED"
                exempt_uri_regular_expression {
                  regex_string = "/api/|.(acc|avi|css|gif|jpe?g|js|pdf|png|tiff?|ttf|webm|webp|woff2?)$"
                }
              }
            }
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesAntiDDoSRuleSet"
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

resource "aws_wafv2_regex_pattern_set" "label_sizerestrictions_body_excluded_paths" {
  name        = "label_sizerestrictions_body_excluded_paths"
  description = "Paths that should not be blocked by the SizeRestrictions_BODY rule"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = "^/api/v1/(dashboard|chart|dataset).*$"
  }

  regular_expression {
    regex_string = "^/superset/explore_json/.*$"
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
# AWS Shield Advanced
#
resource "aws_shield_subscription" "superset" {
  auto_renew = "ENABLED"
}

resource "aws_shield_protection" "superset_alb" {
  name         = "superset-alb"
  resource_arn = aws_lb.superset.arn
  tags         = local.common_tags
}

resource "aws_shield_protection" "superset_route53" {
  name         = "superset-route53"
  resource_arn = aws_route53_zone.superset.arn
  tags         = local.common_tags
}

resource "aws_shield_application_layer_automatic_response" "superset_alb" {
  resource_arn = aws_lb.superset.arn
  action       = "BLOCK"
}

import {
  to = aws_shield_subscription.superset
  id = var.account_id
}
