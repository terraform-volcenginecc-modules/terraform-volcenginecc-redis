# terraform-volcenginecc-redis

## 1. 概述

基于 `volcenginecc` Provider 管理火山引擎 REDIS 资源的 Terraform 模块。调用方负责 Provider 凭据、地域配置，以及通过 ID 传入的外部资源。

## 2. 用法

```hcl
module "redis" {
  source  = "terraform-volcenginecc-modules/redis/volcenginecc"
  version = "~> 1.0"

  # 请设置适用于当前环境的必填模块输入。
}
```

## 3. 示例

- `basic`：可独立运行的 basic 配置。
- `complete`：可独立运行的 complete 配置。

## 4. 依赖要求

| 名称 | 版本 |
|---|---|
| Terraform | `>= 1.5.7` |
| OpenTofu | `>= 1.11.8` |

## 5. Providers

| 名称 | 来源 |
|---|---|
| `volcenginecc` | `volcengine/volcenginecc` |

## 6. 资源

| 名称 | 说明 |
|---|---|
| `volcenginecc_redis_parameter_group` | 模块定义的 volcenginecc_redis_parameter_group。 |
| `volcenginecc_redis_instance` | 模块定义的 volcenginecc_redis_instance。 |
| `volcenginecc_redis_allow_list` | 模块定义的 volcenginecc_redis_allow_list。 |
| `volcenginecc_redis_account` | 模块定义的 volcenginecc_redis_account。 |

## 7. 输入

| 名称 | 说明 |
|---|---|
| `instance_name` | 模块定义的 instance_name。 |
| `vpc_id` | 模块定义的 vpc_id。 |
| `subnet_id` | 模块定义的 subnet_id。 |
| `availability_zones` | 模块定义的 availability_zones。 |
| `multi_az` | 模块定义的 multi_az。 |
| `engine_version` | 模块定义的 engine_version。 |
| `node_number` | 模块定义的 node_number。 |
| `sharded_cluster` | 模块定义的 sharded_cluster。 |
| `shard_number` | 模块定义的 shard_number。 |
| `shard_capacity_mib` | 模块定义的 shard_capacity_mib。 |
| `password` | 模块定义的 password。 |
| `no_auth_mode` | 模块定义的 no_auth_mode。 |
| `allow_list_ids` | 模块定义的 allow_list_ids。 |
| `allow_lists` | 模块定义的 allow_lists。 |
| `parameter_group_id` | 模块定义的 parameter_group_id。 |
| `parameter_group` | 模块定义的 parameter_group。 |
| `accounts` | 模块定义的 accounts。 |
| `charge_type` | 模块定义的 charge_type。 |
| `purchase_months` | 模块定义的 purchase_months。 |
| `auto_renew` | 模块定义的 auto_renew。 |
| `deletion_protection` | 模块定义的 deletion_protection。 |
| `continuous_backup` | 模块定义的 continuous_backup。 |
| `create_backup` | 模块定义的 create_backup。 |
| `port` | 模块定义的 port。 |
| `project_name` | 模块定义的 project_name。 |
| `reserve_additional_bandwidth` | 模块定义的 reserve_additional_bandwidth。 |
| `tags` | 模块定义的 tags。 |

## 8. 输出

| 名称 | 说明 |
|---|---|
| `instance_id` | 模块定义的 instance_id。 |
| `private_address` | 模块定义的 private_address。 |
| `private_port` | 模块定义的 private_port。 |
| `vip` | 模块定义的 vip。 |
| `private_connection` | 模块定义的 private_connection。 |
| `connection_addresses` | 模块定义的 connection_addresses。 |
| `status` | 模块定义的 status。 |
| `maintenance_time` | 模块定义的 maintenance_time。 |
| `allow_list_ids` | 模块定义的 allow_list_ids。 |
| `parameter_group_id` | 模块定义的 parameter_group_id。 |
| `account_names` | 模块定义的 account_names。 |

## 9. 说明

- 请通过 Provider 支持的方式配置凭据，不要将访问密钥写入模块文件。
- 执行变更前请审阅替换行为及 Provider 限制。
- apply 后请再次执行 `terraform plan`，并确认第二次 plan 无变更。
