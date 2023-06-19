variable "vpc_id" {}

variable "public_ip" {
  description = "My public IP address where I will connect to the bastion host"
  default     = "187.21.2.183"
}
