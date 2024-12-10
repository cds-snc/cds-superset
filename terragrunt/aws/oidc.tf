locals {
  cds_superset_release = "cds-superset-release"
}

#
# Create the OIDC roles used by the GitHub workflows
# The roles can be assumed by the GitHub workflows according to the `claim`
# attribute of each role.
# 
module "github_workflow_roles" {
  source            = "github.com/cds-snc/terraform-modules//gh_oidc_role?ref=v10.2.0"
  billing_tag_value = var.billing_tag_value
  roles = [
    {
      name      = local.cds_superset_release
      repo_name = "cds-superset"
      claim     = "ref:refs/tags/v*"
    }
  ]
}

#
# Attach polices to the OIDC roles to grant them permissions.  These
# attachments are scoped to only the environments that require the role.
#
resource "aws_iam_role_policy_attachment" "cds_superset_release" {
  count      = var.env == "prod" ? 1 : 0
  role       = local.cds_superset_release
  policy_arn = data.aws_iam_policy.admin.arn
  depends_on = [
    module.github_workflow_roles
  ]
}

data "aws_iam_policy" "admin" {
  # checkov:skip=CKV_AWS_275:This policy is required for the Terraform apply
  name = "AdministratorAccess"
}
