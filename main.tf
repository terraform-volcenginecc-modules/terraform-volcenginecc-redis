locals {
  managed_allow_list_ids = toset([
    for allow_list in volcenginecc_redis_allow_list.this : allow_list.allow_list_id
  ])

  parameter_group_id = var.parameter_group == null ? var.parameter_group_id : volcenginecc_redis_parameter_group.this[0].parameter_group_id
}

resource "volcenginecc_redis_parameter_group" "this" {
  count = var.parameter_group == null ? 0 : 1

  engine_version = var.engine_version
  name           = var.parameter_group.name
  description    = var.parameter_group.description
  param_values   = var.parameter_group.parameters
}

resource "volcenginecc_redis_instance" "this" {
  configure_nodes = [for availability_zone in var.availability_zones : { az = availability_zone }]
  multi_az        = var.multi_az ? "enabled" : "disabled"
  node_number     = var.node_number
  shard_capacity  = var.shard_capacity_mib
  sharded_cluster = var.sharded_cluster ? 1 : 0
  subnet_id       = var.subnet_id
  vpc_id          = var.vpc_id

  allow_list_ids               = length(var.allow_list_ids) == 0 ? null : var.allow_list_ids
  auto_renew                   = var.auto_renew
  charge_type                  = var.charge_type
  continuous_backup            = var.node_number == 1 ? null : var.continuous_backup
  create_backup                = var.node_number == 1 ? null : var.create_backup
  deletion_protection          = var.deletion_protection ? "enabled" : "disabled"
  engine_version               = var.engine_version
  instance_name                = var.instance_name
  no_auth_mode                 = var.no_auth_mode
  parameter_group_id           = local.parameter_group_id
  password                     = var.password
  port                         = var.port
  project_name                 = var.project_name
  purchase_months              = var.purchase_months
  reserve_additional_bandwidth = var.reserve_additional_bandwidth
  shard_number                 = var.sharded_cluster ? var.shard_number : null
  tags                         = [for key, value in var.tags : { key = key, value = value }]

  lifecycle {
    precondition {
      condition     = var.no_auth_mode == "open" || var.password != null
      error_message = "password must be set unless no_auth_mode is \"open\"."
    }

    precondition {
      condition     = !var.sharded_cluster || var.shard_number != null
      error_message = "shard_number must be set when sharded_cluster is true."
    }

    precondition {
      condition     = !(var.charge_type == "PrePaid" && var.purchase_months == null)
      error_message = "purchase_months must be set when charge_type is PrePaid."
    }

    precondition {
      condition     = var.node_number != 1 || (!var.continuous_backup && !var.create_backup)
      error_message = "continuous_backup and create_backup must both be false for a standalone Redis instance (node_number = 1)."
    }

    precondition {
      condition     = !(var.parameter_group != null && var.parameter_group_id != null)
      error_message = "parameter_group and parameter_group_id are mutually exclusive."
    }

    precondition {
      condition     = !(length(var.allow_lists) > 0 && length(var.allow_list_ids) > 0)
      error_message = "allow_lists and allow_list_ids are mutually exclusive to avoid conflicting allowlist ownership."
    }
  }
}

resource "volcenginecc_redis_allow_list" "this" {
  for_each = var.allow_lists

  allow_list                = each.value.allow_list
  allow_list_category       = each.value.category
  allow_list_desc           = each.value.description
  allow_list_name           = each.value.name
  instance_ids              = toset([volcenginecc_redis_instance.this.instance_id])
  project_name              = var.project_name
  security_group_bind_infos = length(each.value.security_group_bind_infos) == 0 ? null : each.value.security_group_bind_infos
}

resource "volcenginecc_redis_account" "this" {
  for_each = toset(keys(nonsensitive(var.accounts)))

  account_name = var.accounts[each.value].name
  description  = var.accounts[each.value].description
  instance_id  = volcenginecc_redis_instance.this.instance_id
  password     = var.accounts[each.value].password
  role_name    = var.accounts[each.value].role_name
}
