# variable "enable_nat_gateway" {
#   description = "Should be true if you want to provision NAT Gateways for each of your private networks"
#   type        = bool
#   default     = false
# }

variable "public_ip" {
  description = "The public IP address of the NAT Gateway"
  default     = "187.21.2.183"
}

variable "alb_sg_id" {}