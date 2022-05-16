variable "name" {
  description = "Lambda function name"
  type        = string
}

variable "runtime" {
  description = "Runtime for running lambda function"
  type        = string
}

variable "memory_size" {
  description = "Lambda function memory size for execution"
  type        = number
  default     = 128
}

variable "timeout" {
  description = "Lambda function request timeout"
  type        = number
  default     = 120
}

variable "log_retention_period" {
  description = "Lambda function log retention period in days"
  type        = number
  default     = 7
}

variable "handler" {
  description = "Handler for lambda function"
  type        = string
}

variable "environment_vars" {
  default     = null
  description = "The Lambda environment's configuration settings."
  type        = map(string)
}

variable "layer" {
  description = "Lambda layer arn to include"
  type        = string
  default     = ""
}

variable "apigateway_invoke" {
  description = "If true, module will also provision apigateway api to invoke lambda function"
  type        = bool
  default     = false
}

variable "endpoint_type" {
  description = "Api gateway endpoint type for lambda"
  type        = string
  default     = "REGIONAL"
}

variable "vpc_config" {
  default     = null
  description = "Provide this to allow your function to access your VPC. Fields documented below. See Lambda in VPC."
  type = object({
    security_group_ids = list(string)
    subnet_ids         = list(string)
  })
}

variable "s3_events" {
  description = "Events for S3 bucket to invoke lambda functions"
  type        = string
  default     = "s3:ObjectCreated:*"
}

variable "s3_filter_prefix" {
  description = "Allow to set prefix event filter for S3 bucket object"
  type        = string
  default     = ""
}

variable "s3_filter_suffix" {
  description = "Allow to set suffix event filter for S3 bucket object"
  type        = string
  default     = ""
}

variable "s3_event_bucket_name" {
  description = "Name of existing S3 bucket for which to create events"
  type        = list(string)
  default     = []
}

variable "cw_log_groups" {
  description = "Log groups name for subscription and create event on write to log"
  type        = list(string)
  default     = []
}

variable "cw_log_filter_pattern" {
  description = "Log group name filter pattern"
  type        = string
  default     = ""
}

variable "cloudwatch_schedule_invoke" {
  description = "If true, module will also provision event on trigger by timer to invoke lambda function"
  type        = bool
  default     = false
}

variable "cloudwatch_event_pattern_invoke" {
  description = "If true, module will also provision event to trigger by event pattern to invoke lambda function"
  type        = bool
  default     = false
}

variable "cloudwatch_event_pattern" {
  description = "Specify event pattern in JSON format if 'cloudwatch_event_pattern_invoke' is set to true"
  type        = string
  default     = null
}

variable "cw_schedule_value" {
  description = "Rate or cron time at which shoud be lambda triggered"
  type        = string
  default     = "rate(15 minutes)"
}

variable "route53_record" {
  description = "If true, module will also create Route53 record for lambda function"
  type        = bool
  default     = false
}

variable "r53_is_private_zone" {
  description = "Shows which type of r53 zone will be used"
  type        = bool
  default     = false
}

variable "route53_zone_name" {
  description = "Zone name in which shoud be created a domain record for lambda function"
  type        = string
  default     = ""
}

variable "concurrency" {
  description = "The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. "
  type        = number
  default     = "-1"
}

variable "policy" {
  description = "The policy document. This is a JSON formatted string."
  type        = string
  default     = null
}

variable "source_code_hash" {
  description = "Used to trigger updates when file contents change.  Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3_key."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of what your Lambda Function does."
  type        = string
  default     = ""
}

variable "filename" {
  description = "The path to the function's deployment package within the local filesystem. If defined. No S3 support"
  type        = string
  default     = ""
}

variable "create_bucket" {
  description = "If true, it will create a bucket and upload zipped function into that bucket"
  type        = bool
  default     = false
}

variable "s3_bucket" {
  description = "The S3 bucket location containing the function's deployment package. Conflicts with filename. This bucket must reside in the same AWS region where you are creating the Lambda function"
  type        = string
  default     = ""
}

variable "s3_key" {
  description = "The S3 key of an object containing the function's deployment package. Conflicts with filename."
  type        = string
  default     = ""
}

variable "file_path" {
  description = "The path to a file that will be read and uploaded as raw bytes for the object content."
  type        = string
  default     = ""
}

variable "s3_object_version" {
  description = "The object version containing the function's deployment package. Conflicts with filename."
  type        = string
  default     = null
}

variable "acl" {
  type        = string
  default     = "private"
  description = "Specify the canned ACL to apply. Defaults to 'private'."
}

variable "server_side_encryption_configuration" {
  type        = map(string)
  default     = {}
  description = "Specify sse_algorithm and/or kms_master_key_id"
}

variable "public_access_block" {
  type = map(string)
  default = {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }
  description = "(Optional) Provide a map to override specific keys: block_public_acls, block_public_policy, ignore_public_acls, restrict_public_buckets"
}


# Tags
variable "project" {
  description = "Name of the project Ex : mypay"
  type        = string
}

variable "organization" {
  description = "Name of the organisation Ex : MyPay/Datman"
  type        = string
}

variable "environment" {
  description = "Name of the environment Ex : test/prod"
  type        = string
}

variable "override_cost_tags" {
  type        = map(string)
  default     = {}
  description = "Override the cost tags"
}

variable "override_base_tags" {
  type        = map(string)
  default     = {}
  description = "Override the base tags"
}