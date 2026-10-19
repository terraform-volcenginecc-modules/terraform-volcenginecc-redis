variable "instance_name" {
  type        = string
  description = "Name for the primary-secondary Redis instance."
  default     = "redis-complete-example"
}

variable "region" {
  type        = string
  description = "Volcengine region for this example."
  default     = "cn-beijing"
}

variable "vpc_id" {
  type        = string
  description = "Existing VPC ID."
  default     = "vpc-btoy1n92n11c5h0b2ul0jz9c"
}

variable "subnet_id" {
  type        = string
  description = "Existing subnet ID in the first availability zone."
  default     = "subnet-1a1nd7d2m67sw8nvepjx9sbai"
}

variable "availability_zones" {
  type        = list(string)
  description = "Node availability zones for the primary-secondary instance. Supply two entries to match the two nodes."
  default     = ["cn-beijing-a", "cn-beijing-a"]
}

variable "application_cidr" {
  type        = string
  description = "Trusted private CIDR required together with the security-group binding."
  default     = "192.168.19.0/24"
}

variable "password" {
  type        = string
  description = "Default account password."
  sensitive   = true
}
