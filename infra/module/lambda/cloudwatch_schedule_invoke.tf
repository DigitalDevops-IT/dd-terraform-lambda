resource "aws_cloudwatch_event_rule" "default" {
  count = var.cloudwatch_schedule_invoke ? 1 : 0

  name                = "${aws_lambda_function.default.function_name}-trigger"
  description         = "Triggers every ${var.cw_schedule_value}"
  schedule_expression = var.cw_schedule_value

  tags = merge(
    module.tagscost.cost_tags,
    module.tagsbase.base_tags
  )
}

resource "aws_cloudwatch_event_target" "default" {
  count = var.cloudwatch_schedule_invoke ? 1 : 0

  rule      = aws_cloudwatch_event_rule.default[count.index].name
  target_id = "${aws_lambda_function.default.function_name}-id"
  arn       = aws_lambda_function.default.arn
}

resource "aws_lambda_permission" "cw_trigger_lambda" {
  count = var.cloudwatch_schedule_invoke ? 1 : 0

  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.default.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.default[count.index].arn
}