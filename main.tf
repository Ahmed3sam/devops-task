# Configure the AWS Provider
provider "aws" {
   region  = "${var.region}"
}


module "network1" {
    source = "./network1"
}


module "network_module" {
    source = "./network_module"
}


module "loadbalancer_module" {
    source = "./loadbalancer_module"
    publicsg_id = "${module.network_module.publicsg_id}"
    privatesg_id = "${module.network_module.privatesg_id}"
}

module "autoscaling_module" {
    source = "./autoscaling_module"
    targetgroup = "${module.loadbalancer_module.targetgroup}"
    lbarn = "${module.loadbalancer_module.lbarn}"
    launchconfig_name = "${module.loadbalancer_module.launchconfig_name}"
    
}

module "rds_module" {
    source = "./rds_module"
  
}