resource "aws_ecr_repository" "superset-image" {
  name                 = "superset"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    CostCentre = var.billing_code
    Terraform  = true
  }
}