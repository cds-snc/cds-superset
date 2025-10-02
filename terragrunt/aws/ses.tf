#
# Send email using a SES SMTP server
#
resource "aws_ses_domain_identity" "superset" {
  domain = var.domain
}

resource "aws_ses_domain_dkim" "superset" {
  domain = aws_ses_domain_identity.superset.domain
}

resource "aws_ses_domain_identity_verification" "superset" {
  domain     = aws_ses_domain_identity.superset.id
  depends_on = [aws_route53_record.superset_ses_verification_TXT]
}

resource "aws_iam_user" "superset_send_email" {
  name = "superset_send_email"
}

resource "aws_iam_group" "superset_send_email" {
  name = "superset_send_email"
}

resource "aws_iam_group_membership" "superset_send_email" {
  name  = aws_iam_user.superset_send_email.name
  group = aws_iam_group.superset_send_email.name
  users = [
    aws_iam_user.superset_send_email.name
  ]
}

resource "aws_iam_group_policy_attachment" "superset_send_email" {
  group      = aws_iam_user.superset_send_email.name
  policy_arn = aws_iam_policy.superset_send_email.arn
}

data "aws_iam_policy_document" "superset_send_email" {
  statement {
    effect = "Allow"
    actions = [
      "ses:SendRawEmail"
    ]
    resources = [
      aws_ses_domain_identity.superset.arn
    ]
  }
}

resource "aws_iam_policy" "superset_send_email" {
  name   = "superset_send_email"
  policy = data.aws_iam_policy_document.superset_send_email.json
}

resource "aws_iam_access_key" "superset_send_email" {
  user = aws_iam_user.superset_send_email.name
}