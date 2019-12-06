# required
variable "alb_listener_arn" {
  description = "Listener to add the rule(s) to"
  type        = string
}

variable "target_group_arn" {
  description = "Target group to direct traffic to"
  type        = string
}

# optional
variable "path_conditions" {
  description = "Defines path-based conditions for routing; separate by, eg. '/home,/home/*'"
  type        = list(string)
  default     = ["*"]
}

variable "host_condition" {
  description = "Defines host-based condition for rule (domain name)"
  type        = string
  default     = "*.*"
}

variable "starting_priority" {
  description = "Starting priority for rules that will be added"
  default     = 50
}

