resource "aws_ecr_repository" "superset-image" {
  name                 = "superset"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = local.common_tags
}

resource "aws_ecr_lifecycle_policy" "superset-image" {
  repository = aws_ecr_repository.superset-image.name
  policy     = <<-EOT
  {
    "rules": [
        {
            "rulePriority": 10,
            "description": "Keep last 10 git SHA tagged images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": [
                    "sha-"
                ],
                "countType": "imageCountMoreThan",
                "countNumber": 10
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 20,
            "description": "Expire untagged images older than 7 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 7
            },
            "action": {
                "type": "expire"
            }
        }
    ]
  }
  EOT
}
