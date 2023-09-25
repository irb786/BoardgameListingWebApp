variable "cidr_block" {
  type    = list(string)
  default = ["172.20.0.0/16", "172.20.10.0/24"]

}
variable "ports" {
  type    = list(number)
  default = [22,25,8083,8070,6443,5432,465, 80, 443, 8080, 8081,8082,9000,9876,27017,6379,1025,3306,4200,5432,3389,9002]

}

variable "ami" {
    type = string
    default = "ami-024e6efaf93d85776"
  
}

variable "instance_type" {
    type = string
    default = "t2.large"
}

variable "instance_type_for_nexus" {
  type = string
  default = "t2.medium"
  
}
variable "nexusami" {
    type = string
    default = "ami-02b8534ff4b424939"
  
}


variable "test_instance" {
  type = string
  default = "t2.large"
  
}
variable "test_ami" {
    type = string
    default = "ami-024e6efaf93d85776"
  
}


# variable "offering" {
  
# }

