variable "region" {
  description = "Location to deploy to."
  type        = string
  default     = "us-west-2"
}

variable "instance_type" {
  description = "Size of Server to start."
  type        = string
  default     = "t3.medium"
}

variable "admin_ip_addresses" {
  description = "Comma seperated string of IP addresses authorized to access Instance"
  type        = string
  default     = "0.0.0.0/0"
  sensitive   = true
}

variable "friend_list" {
  description = "Comma seperated string of IP addresses allowed to join to server"
  type        = string
  default     = "0.0.0.0/0"
  sensitive   = true
}