variable "instance_name" {
  type        = string
  description = "Name of the Redis instance."

  validation {
    condition     = length(var.instance_name) >= 1 && length(var.instance_name) <= 128 && can(regex("^[^0-9-][A-Za-z0-9_-]*$", var.instance_name))
    error_message = "instance_name must be 1-128 characters, must not start with a digit or hyphen, and may contain letters, digits, underscores, or hyphens."
  }
}

variable "vpc_id" {
  type        = string
  description = "ID of the existing VPC that owns the Redis private endpoint."
  nullable    = false
}

variable "subnet_id" {
  type        = string
  description = "ID of the existing subnet in the same availability zone as the Redis nodes."
  nullable    = false
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones for Redis nodes. Supply two zones when multi_az is true."
  nullable    = false

  validation {
    condition     = length(var.availability_zones) >= 1
    error_message = "availability_zones must contain at least one availability zone."
  }
}

variable "multi_az" {
  type        = bool
  description = "Whether to request a multi-availability-zone deployment."
  default     = false
  nullable    = false
}

variable "engine_version" {
  type        = string
  description = "Redis engine version."
  default     = "7.0"
  nullable    = false

  validation {
    condition     = contains(["5.0", "6.0", "7.0"], var.engine_version)
    error_message = "engine_version must be one of: 5.0, 6.0, 7.0."
  }
}

variable "node_number" {
  type        = number
  description = "Number of nodes per shard. Use 1 for standalone and at least 2 for primary-secondary."
  default     = 1
  nullable    = false

  validation {
    condition     = var.node_number >= 1 && var.node_number <= 6 && floor(var.node_number) == var.node_number
    error_message = "node_number must be an integer from 1 through 6."
  }
}

variable "sharded_cluster" {
  type        = bool
  description = "Whether to enable sharded cluster mode."
  default     = false
  nullable    = false
}

variable "shard_number" {
  type        = number
  description = "Number of shards when sharded_cluster is true. This Provider requires a replacement when changed."
  default     = null

  validation {
    condition     = var.shard_number == null ? true : (var.shard_number >= 2 && var.shard_number <= 256 && floor(var.shard_number) == var.shard_number)
    error_message = "shard_number must be null or an integer from 2 through 256."
  }
}

variable "shard_capacity_mib" {
  type        = number
  description = "Memory capacity for each shard, in MiB."
  nullable    = false

  validation {
    condition     = var.shard_capacity_mib > 0 && floor(var.shard_capacity_mib) == var.shard_capacity_mib
    error_message = "shard_capacity_mib must be a positive integer."
  }
}

variable "password" {
  type        = string
  description = "Password for the default Redis account. Required unless no_auth_mode is open."
  default     = null
  sensitive   = true
}

variable "no_auth_mode" {
  type        = string
  description = "Private-network authentication mode. Keep the default close for password authentication."
  default     = "close"
  nullable    = false

  validation {
    condition     = contains(["open", "close"], var.no_auth_mode)
    error_message = "no_auth_mode must be either open or close."
  }
}

variable "allow_list_ids" {
  type        = set(string)
  description = "Existing allowlist IDs to associate during instance creation. Do not set this together with allow_lists because the Provider models both as instance associations."
  default     = []
  nullable    = false
}

variable "allow_lists" {
  type = map(object({
    name        = string
    allow_list  = optional(string)
    category    = optional(string, "Ordinary")
    description = optional(string)
    security_group_bind_infos = optional(set(object({
      bind_mode         = string
      security_group_id = string
    })), [])
  }))
  description = "Allowlists managed by this module. The map key is stable Terraform identity. Each entry needs allow_list or security_group_bind_infos."
  default     = {}
  nullable    = false

  validation {
    condition = alltrue([
      for allow_list in values(var.allow_lists) :
      (try(trimspace(allow_list.allow_list), "") != "" || length(allow_list.security_group_bind_infos) > 0) &&
      !contains(split(",", allow_list.allow_list == null ? "" : allow_list.allow_list), "0.0.0.0/0")
    ])
    error_message = "Each allow_lists entry must specify IP/CIDR values or security_group_bind_infos, and must not include 0.0.0.0/0."
  }
}

variable "parameter_group_id" {
  type        = string
  description = "ID of an existing Redis parameter group. Mutually exclusive with parameter_group."
  default     = null
}

variable "parameter_group" {
  type = object({
    name        = string
    description = optional(string)
    parameters = set(object({
      name  = string
      value = string
    }))
  })
  description = "Custom parameter group managed by this module. Its engine version always matches engine_version."
  default     = null
}

variable "accounts" {
  type = map(object({
    name        = string
    password    = string
    role_name   = string
    description = optional(string)
  }))
  description = "Additional Redis accounts managed by this module. The map key is stable Terraform identity."
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition = alltrue([
      for account in values(var.accounts) :
      can(regex("^[a-z][a-z0-9_]{0,14}[a-z0-9]$", account.name)) &&
      contains(["Administrator", "ReadWrite", "ReadOnly", "NotDangerous"], account.role_name)
    ])
    error_message = "Account names must be 2-16 lowercase letters, digits, or underscores and roles must be supported Redis default roles."
  }
}

variable "charge_type" {
  type        = string
  description = "Billing type: PostPaid or PrePaid."
  default     = "PostPaid"
  nullable    = false

  validation {
    condition     = contains(["PostPaid", "PrePaid"], var.charge_type)
    error_message = "charge_type must be PostPaid or PrePaid."
  }
}

variable "purchase_months" {
  type        = number
  description = "Subscription duration in months. Required by the cloud when charge_type is PrePaid."
  default     = null

  validation {
    condition     = var.purchase_months == null ? true : contains([1, 2, 3, 4, 5, 6, 7, 8, 9, 12, 24, 36], var.purchase_months)
    error_message = "purchase_months must be one of 1-9, 12, 24, or 36."
  }
}

variable "auto_renew" {
  type        = bool
  description = "Whether to enable auto-renewal for a prepaid instance."
  default     = false
  nullable    = false
}

variable "deletion_protection" {
  type        = bool
  description = "Whether to enable cloud-side deletion protection."
  default     = true
  nullable    = false
}

variable "continuous_backup" {
  type        = bool
  description = "Whether to enable data flashback. This is the only backup-policy control exposed by the Provider."
  default     = false
  nullable    = false
}

variable "create_backup" {
  type        = bool
  description = "Whether the cloud should create a full backup before a supported change."
  default     = false
  nullable    = false
}

variable "port" {
  type        = number
  description = "Private endpoint port. The cloud default is 6379 when null."
  default     = null

  validation {
    condition     = var.port == null ? true : (var.port >= 1024 && var.port <= 65535 && floor(var.port) == var.port)
    error_message = "port must be null or an integer from 1024 through 65535."
  }
}

variable "project_name" {
  type        = string
  description = "Optional Volcengine project name."
  default     = null
}

variable "reserve_additional_bandwidth" {
  type        = bool
  description = "Whether to reserve additional bandwidth."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the Redis instance."
  default     = {}
  nullable    = false
}
