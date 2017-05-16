AWS ALB Listener Rule terraform module
======================================

This module creates AWS ALB Listener rules as per provided parameters; it supports host-based routing conditions and path-based conditions (so pretty much what is supported).

Due to potential complexity to logic if multiple host-based conditions and path-based conditions specified at the same time, this module is limited to support up to one host-based condition, while supporting multiple path-based conditions.

Module Input Variables
----------------------

- `alb_listener_arn` - (string) - **REQUIRED** - AWS ALB Listener ARN to attach the rules to 
- `target_group_arn` - (string) - **REQUIRED** - AWS ECS Service target group to direct the matching traffic to
- `path_conditions` - (list) - OPTIONAL - path-based conditions for the rules, separated by `,` - eg. `"/home,/about,/info/*"`, default: `"*"`
- `host_condition` - (string) - OPTIONAL - host-based condition for the rules, can be only one, eg. `"sub.domain.com"`, default: `"*.*"`
- `priority` - (int) - OPTIONAL - Starting priority for rules that will be added. ALB evaluates rules in order of piority (which must be unique) and this module results in one rule per path condition, so it is suggested that you use multiples of 10. Default: `"50"`

Path-based condition support wildcard characters - see [AWS Documentation](http://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-listeners.html#path-conditions) to see how to use them.

Usage
-----

```hcl
module "listener_rule_home" {
  source = "github.com/mergermarket/tf_alb_listener_rules"

  alb_listener_arn = "arn:aws:elasticloadbalancing:us-east-1:123456789012:listener/app/my-load-balancer/50dc6c495c0c9188/f2f7dc8efc522ab2"
  target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/my-targets/73e2d6bc24d8a067"

  path_conditions   = ["/home", "/home/*"]
  host_condition    = "sub.domain.com"
  starting_priority = 10
}
```

Outputs
=======

This module does not output anything.
