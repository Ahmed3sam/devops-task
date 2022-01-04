output "vpcid" {
    value = "${local.vcpid}"
}

output "publicsubnet1id" {
    value = "${local.publicsubnet1id}"
}

output "privatesubnet1id" {
    value = "${local.privatesubnet1id}"
}

output "publicsubnet2id" {
    value = "${local.publicsubnet2id}"
}

output "privatesubnet2id" {
    value = "${local.privatesubnet2id}"
}

output "env_suffix" {
    value = "${local.env}"
}

output "instancetype" {
    value = "${local.instancetype}"
}

output "keyname" {
    value = "${local.keyname}"
}


locals {
    env = "${terraform.workspace}"

    vcpid_env = {
        default = "vpc-0f8ed22319de5e449"
        staging = "vpc-0f8ed22319de5e449"
        production = "vpc-0f8ed22319de5e449"
    }
    vcpid = "${lookup(local.vcpid_env, local.env)}"

    publicsubnet1id_env = {
        default = "subnet-09797237517e42fc8"
        staging = "subnet-09797237517e42fc8"
        production = "subnet-09797237517e42fc8"
    }
    publicsubnet1id = "${lookup(local.publicsubnet1id_env, local.env)}"

    publicsubnet2id_env = {
        default = "subnet-00eb6d73360c54681"
        staging = "subnet-00eb6d73360c54681"
        production = "subnet-00eb6d73360c54681"
    }
    publicsubnet2id = "${lookup(local.publicsubnet2id_env, local.env)}"

    privatesubnet1id_env = {
        default = "subnet-09a24ff870fbbacbe"
        staging = "subnet-09a24ff870fbbacbe"
        production = "subnet-09a24ff870fbbacbe"
    }
    privatesubnet1id = "${lookup(local.privatesubnet1id_env, local.env)}"

    privatesubnet2id_env = {
        default = "subnet-0267d6fe8a4dffa64"
        staging = "subnet-0267d6fe8a4dffa64"
        production = "subnet-0267d6fe8a4dffa64"
    }
    privatesubnet2id = "${lookup(local.privatesubnet2id_env, local.env)}"

        instancetype_env = {
        default = "t2.micro"
        staging = "t2.micro"
        production = "t2.medium"
    }
    instancetype = "${lookup(local.instancetype_env, local.env)}"


    keyname_env =  {
        default = "devops-task-stage"
        staging = "devops-task-stage"
        production = "devops-task-prod"
    }
    keyname = "${lookup(local.keyname_env, local.env)}"
}




