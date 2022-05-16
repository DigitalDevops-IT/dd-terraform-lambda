resource "aws_iam_role" "default" {
  name = "${var.name}-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = merge(
    module.tagscost.cost_tags,
    module.tagsbase.base_tags
  )

}

resource "aws_iam_policy" "default" {
  name = "${var.name}-policy"

  policy = var.policy
}

resource "aws_iam_role_policy_attachment" "lambda_permissions" {
  role       = aws_iam_role.default.name
  policy_arn = aws_iam_policy.default.arn
}