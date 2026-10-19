# terraform-volcenginecc-redis

## 1. Overview

Terraform module for managing Volcengine REDIS resources with the `volcenginecc` provider. The caller owns provider authentication, region configuration, and external resources passed by ID.

## 2. Usage

```hcl
module "redis" {
  source  = "terraform-volcenginecc-modules/redis/volcenginecc"
  version = "~> 1.0"

  # Set the required module inputs for your environment.
}
```

## 3. Examples

- `basic`: independently runnable basic configuration.
- `complete`: independently runnable complete configuration.

## 4. Requirements

| Name | Version |
|---|---|
| Terraform | `>= 1.5.7` |
| OpenTofu | `>= 1.11.8` |

## 5. Providers

| Name | Source |
|---|---|
| `volcenginecc` | `volcengine/volcenginecc` |

## 6. Resources

| Name | Description |
|---|---|
| `volcenginecc_redis_parameter_group` | Module-defined volcenginecc_redis_parameter_group. |
| `volcenginecc_redis_instance` | Module-defined volcenginecc_redis_instance. |
| `volcenginecc_redis_allow_list` | Module-defined volcenginecc_redis_allow_list. |
| `volcenginecc_redis_account` | Module-defined volcenginecc_redis_account. |

## 7. Inputs

| Name | Description |
|---|---|
| `instance_name` | Module-defined instance_name. |
| `vpc_id` | Module-defined vpc_id. |
| `subnet_id` | Module-defined subnet_id. |
| `availability_zones` | Module-defined availability_zones. |
| `multi_az` | Module-defined multi_az. |
| `engine_version` | Module-defined engine_version. |
| `node_number` | Module-defined node_number. |
| `sharded_cluster` | Module-defined sharded_cluster. |
| `shard_number` | Module-defined shard_number. |
| `shard_capacity_mib` | Module-defined shard_capacity_mib. |
| `password` | Module-defined password. |
| `no_auth_mode` | Module-defined no_auth_mode. |
| `allow_list_ids` | Module-defined allow_list_ids. |
| `allow_lists` | Module-defined allow_lists. |
| `parameter_group_id` | Module-defined parameter_group_id. |
| `parameter_group` | Module-defined parameter_group. |
| `accounts` | Module-defined accounts. |
| `charge_type` | Module-defined charge_type. |
| `purchase_months` | Module-defined purchase_months. |
| `auto_renew` | Module-defined auto_renew. |
| `deletion_protection` | Module-defined deletion_protection. |
| `continuous_backup` | Module-defined continuous_backup. |
| `create_backup` | Module-defined create_backup. |
| `port` | Module-defined port. |
| `project_name` | Module-defined project_name. |
| `reserve_additional_bandwidth` | Module-defined reserve_additional_bandwidth. |
| `tags` | Module-defined tags. |

## 8. Outputs

| Name | Description |
|---|---|
| `instance_id` | Module-defined instance_id. |
| `private_address` | Module-defined private_address. |
| `private_port` | Module-defined private_port. |
| `vip` | Module-defined vip. |
| `private_connection` | Module-defined private_connection. |
| `connection_addresses` | Module-defined connection_addresses. |
| `status` | Module-defined status. |
| `maintenance_time` | Module-defined maintenance_time. |
| `allow_list_ids` | Module-defined allow_list_ids. |
| `parameter_group_id` | Module-defined parameter_group_id. |
| `account_names` | Module-defined account_names. |

## 9. Notes

- Configure credentials using supported provider mechanisms; do not put access keys in module files.
- Review replacement behavior and provider constraints before applying changes.
- Run `terraform plan` after apply and confirm that the second plan has no changes.
