resource "aws_cloudwatch_log_subscription_filter" "default" {
  for_each = toset(var.cw_log_groups)

  name            = "${var.name}-${data.aws_cloudwatch_log_group.default[each.key].id}"
  log_group_name  = data.aws_cloudwatch_log_group.default[each.key].id
  filter_pattern  = var.cw_log_filter_pattern
  destination_arn = aws_lambda_function.default.arn
}

resource "aws_lambda_permission" "cw_instance" {
  for_each = toset(var.cw_log_groups)

  statement_id_prefix = "AllowCloudWatchInvoke"
  action              = "lambda:InvokeFunction"
  function_name       = aws_lambda_function.default.function_name
  principal           = "logs.eu-west-1.amazonaws.com"
  source_arn          = data.aws_cloudwatch_log_group.default[each.key].arn
}

data "aws_cloudwatch_log_group" "default" {
  for_each = toset(var.cw_log_groups)
  name     = each.key
}