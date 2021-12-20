variable "compartment_id" {
  type = string
}

variable "region" {
  type = string
}

variable "vcn_dns_label" {
  type = string
  default = "vcn"
}

variable "subnet_dns_label" {
  type = string
  default = "subnet"
}