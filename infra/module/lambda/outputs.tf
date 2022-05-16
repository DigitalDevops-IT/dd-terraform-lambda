output "id" {
  description = "Lambda function ID."
  value       = aws_lambda_function.default.id
}

output "arn" {
  description = "Lambda function ARN."
  value       = aws_lambda_function.default.arn
}