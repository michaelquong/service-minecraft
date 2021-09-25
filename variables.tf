variable "region" {
  description = "Location to deploy to."
  type        = string
  default     = "us-west-2"
}

variable "instance_type" {
  description = "Size of Server to start."
  type        = string
  default     = "t3.micro"
}

variable "admin_ip_addresses" {
  description = "IP addresses authorized to access Instance"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "friend_list" {
  description = "IP addresses allowed to join to server"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}