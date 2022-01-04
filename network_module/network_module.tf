module "shared_vars" {
    source = "../shared_vars"
}


# Create security group for load balancer
resource "aws_security_group" "publicsg" {
  name        = "${var.sg_name}_${module.shared_vars.env_suffix}"
  description = "${var.sg_description}_${module.shared_vars.env_suffix}"
  vpc_id      = "${module.shared_vars.vpcid}"
ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
 
 tags = {
    Name = "${var.sg_tagname}"
    Project = "devops-task" 
  } 
}

output "publicsg_id" {
    value = "${aws_security_group.publicsg.id}"
}
# Create security group for webserver
resource "aws_security_group" "privatesg" {
  name        = "${var.sg_ws_name}_${module.shared_vars.env_suffix}"
  description = "${var.sg_ws_description}_${module.shared_vars.env_suffix}"
  vpc_id      = "${module.shared_vars.vpcid}"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
   }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "${var.sg_ws_tagname}" 
    Project = "devops-task"
  }
}


output "privatesg_id" {
    value = "${aws_security_group.privatesg.id}"
}