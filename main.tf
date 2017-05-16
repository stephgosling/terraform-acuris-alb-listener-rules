resource "aws_alb_listener_rule" "rule" {
  count = "${length(var.path_conditions)}"

  listener_arn = "${var.alb_listener_arn}"
  priority     = "${var.priority + count.index}"

  action {
    type             = "forward"
    target_group_arn = "${var.target_group_arn}"
  }

  # Always pass host-based routing condition, with '*.*' being default
  #
  # NOTE: You can have multiple paths but only a single hostname
  condition {
    field  = "host-header"
    values = ["${var.host_condition}"]
  }

  condition {
    field  = "path-pattern"
    values = ["${element(var.path_conditions, count.index)}"]
  }
}
