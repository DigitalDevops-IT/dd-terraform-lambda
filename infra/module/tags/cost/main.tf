
# Common cost allocation tags to be assigned to all resources

locals {
  # Common cost allocation tags to be assigned to all resources
  cost_tags = merge(
    {
      CAT_Owner   = "DevOps",
      CAT_Program = "mypay",
      CAT_Project = "dba"
    },
    var.override_cost_tags
  )
}

variable "override_cost_tags" {
  type        = map(string)
  default     = {}
  description = "A map list of cost tags to use with terraform resources"

}

output "cost_tags" {
  description = "Output of all the cost tags"
  value       = local.cost_tags
}