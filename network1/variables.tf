variable "vpc_cidr" {
  type        = string
  default     = "172.32.0.0/16"
  description = "default vpc_cidr_block"
}


variable "pub_sub1_cidr_block"{
   type        = string
   default     = "172.32.1.0/24"
}

variable "pub_sub2_cidr_block"{
   type        = string
   default     = "172.32.2.0/24"
}
variable "prv_sub1_cidr_block"{
   type        = string
   default     = "172.32.3.0/24"
}
variable "prv_sub2_cidr_block"{
   type        = string
   default     = "172.32.4.0/24"
}