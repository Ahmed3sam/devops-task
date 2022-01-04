module "shared_vars" {
    source = "../shared_vars"
}
variable publicsg_id {}
variable privatesg_id {}
#Create ALB
resource "aws_lb" "ALB-tf" {
   name              = "Demo-ALG-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups  = ["${var.publicsg_id}"]
  subnets          = flatten(["${module.shared_vars.publicsubnet1id}" , "${module.shared_vars.publicsubnet2id}"])    
  tags = {
        name  = "Demo-AppLoadBalancer-tf"
        Environemnt = "${module.shared_vars.env_suffix}"
       }
}

output "lbarn" {
    value = "${aws_lb.ALB-tf.arn}"
}

# Create Target group
resource "aws_lb_target_group" "TG-tf" {
  name     = "Demo-TargetGroup-tf-${module.shared_vars.env_suffix}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${module.shared_vars.vpcid}"

}

output "targetgroup" {
    value = "${aws_lb_target_group.TG-tf.arn}"
}
#Create Launch config
resource "aws_launch_configuration" "webserver-launch-config" {
  name_prefix   = "webserver-launch-config-${module.shared_vars.env_suffix}"
  image_id      =  var.ami
  instance_type = "${module.shared_vars.instancetype}"
  key_name = "${module.shared_vars.keyname}"
  security_groups = ["${var.privatesg_id}"]

  user_data = "${file("assets/script.sh")}"
}

output "launchconfig_name" {
    value = "${aws_launch_configuration.webserver-launch-config.name}"
}