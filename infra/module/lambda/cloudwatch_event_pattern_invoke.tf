resource "aws_cloudwatch_event_rule" "cloudwatch_event_pattern_invoke" {
  count = var.cloudwatch_event_pattern_invoke ? 1 : 0

  name          = "${aws_lambda_function.default.function_name}-event-pattern-trigger"
  description   = "Triggered by event pattern"
  event_pattern = var.cloudwatch_event_pattern

  tags = merge(
    module.tagscost.cost_tags,
    module.tagsbase.base_tags
  )
}

resource "aws_cloudwatch_event_target" "cloudwatch_event_pattern_invoke" {
  count = var.cloudwatch_event_pattern_invoke ? 1 : 0

  rule      = aws_cloudwatch_event_rule.cloudwatch_event_pattern_invoke[count.index].name
  arn       = aws_lambda_function.default.arn
}

resource "aws_lambda_permission" "cloudwatch_event_pattern_invoke" {
  count = var.cloudwatch_event_pattern_invoke ? 1 : 0

  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.default.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cloudwatch_event_pattern_invoke[count.index].arn
}