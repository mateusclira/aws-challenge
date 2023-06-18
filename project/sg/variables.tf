variable "vpc_id" {}

variable "public_ip" {
  description = "The public IP address of the NAT Gateway"
  default     = "187.21.2.183"
}
