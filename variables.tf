variable "region" {
  default = "ap-south-1"
}

variable "cluster_name" {
  default = "demo-eks"
}

variable "vpc_cidr" {
  default = "10.1.0.0/16"
}

variable "jenkins_vpc_id" {
  default = "vpc-0df1c368ab0043668"
}

variable "jenkins_vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "jenkins_route_table_id" {
  default = "rtb-00b43ea071a6d6792"
}