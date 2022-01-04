module "shared_vars" {
    source = "../shared_vars"
}


variable targetgroup {}
variable lbarn {}
variable launchconfig_name {}
# Create Auto Scaling Group
resource "aws_autoscaling_group" "Demo-ASG-tf" {
  name       = "Demo-ASG-tf"
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1
  target_group_arns  = ["${var.targetgroup}"]
  health_check_type  = "EC2"
  launch_configuration = "${var.launchconfig_name}"
  vpc_zone_identifier = flatten(["${module.shared_vars.privatesubnet1id}" , "${module.shared_vars.privatesubnet2id}"])
  
 tag {
       key                 = "Name"
       value               = "Demo-ASG-tf"
       propagate_at_launch = true
    }
}




# Create ALB Listener
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${var.lbarn}"
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = "${var.targetgroup}"
  }
}