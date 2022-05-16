
# Common base allocation tags to be assigned to all resources 

locals {

  # Common base allocation tags to be assigned to all resources
  base_tags = merge(
    {
      Name        = "notDefined",
      Project     = "notDefined",
      Environment = "notDefined",
      App         = "notDefined",
      Managed_by  = "terraform"
    },
    var.override_base_tags
  )
}

variable "override_base_tags" {
  type        = map(string)
  default     = {}
  description = "A map list of base tags to use with terraform resources"
}

output "base_tags" {
  description = "Output of all the base tags"
  value       = local.base_tags
}