# Role used to interact with AWS Resources by AWS Task


resource "aws_iam_role" "superset_task_execution_role" {
  name               = "superset_task_execution_role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume.json
}


data "aws_iam_policy_document" "ecs_task_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_managed" {
  role       = aws_iam_role.superset_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_policy" "superset_task_execution_policy" {
  name        = "superset_task_execution_policy"
  description = "Policy for superset task execution"
  policy      = data.aws_iam_policy_document.superset_task_execution_role.json
}

data "aws_iam_policy_document" "superset_task_execution_role" {

  statement {
    effect = "Allow"
    actions = [
      "logs:DescribeLogGroups"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "${aws_cloudwatch_log_group.superset.arn}:*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "ecr:GetDownloadUrlForlayer",
      "ecr:BatchGetImage"
    ]

    resources = [aws_ecr_repository.superset.arn]
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.superset_task_execution_role.name
  policy_arn = aws_iam_policy.superset_task_execution_policy.arn
}

# Role used inside the task to do things

resource "aws_iam_role" "superset_task_role" {
  name               = "superset_task_role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume.json
}

