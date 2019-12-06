resource "aws_alb_listener_rule" "rule" {
  count = length(var.path_conditions)

  listener_arn = var.alb_listener_arn
  priority     = var.starting_priority + count.index

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }

  # Always pass host-based routing condition, with '*.*' being default
  #
  # NOTE: You can have multiple paths but only a single hostname
  condition {
    field  = "host-header"
    values = [var.host_condition]
  }

  condition {
    field = "path-pattern"
    # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
    # force an interpolation expression to be interpreted as a list by wrapping it
    # in an extra set of list brackets. That form was supported for compatibility in
    # v0.11, but is no longer supported in Terraform v0.12.
    #
    # If the expression in the following list itself returns a list, remove the
    # brackets to avoid interpretation as a list of lists. If the expression
    # returns a single list item then leave it as-is and remove this TODO comment.
    values = [element(var.path_conditions, count.index)]
  }
}

