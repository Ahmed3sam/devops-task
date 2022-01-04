module "shared_vars" {
    source = "../shared_vars"
}

resource "aws_db_subnet_group" "sg1" {
  name       = "security-group-1"
  subnet_ids = ["${module.shared_vars.privatesubnet1id}", "${module.shared_vars.privatesubnet2id}"]
}

resource "aws_db_instance" "mydb1" {
  allocated_storage        = 256 # gigabytes
  backup_retention_period  = 7   # in days
  db_subnet_group_name     = "${aws_db_subnet_group.sg1.name}"
  engine                   = "postgres"
  engine_version           = "11.5"
  identifier               = "mydb1"
  instance_class           = "db.r3.large"
  multi_az                 = false
  name                     = "mydb1"
  password                 = "${file("assets/mydb1_password.txt")}"
  port                     = 5432
  publicly_accessible      = true
  storage_encrypted        = true # you should always do this
  storage_type             = "gp2"
  username                 = "mydb1"
  vpc_security_group_ids   = ["${aws_security_group.mydb1.id}"]
}


resource "aws_security_group" "mydb1" {
  name = "mydb1"

  description = "RDS postgres servers (terraform-managed)"
  vpc_id = "${module.shared_vars.vpcid}"

  # Only postgres in
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}