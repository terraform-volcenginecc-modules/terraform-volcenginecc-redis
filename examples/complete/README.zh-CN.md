# COMPLETE REDIS 示例

## 1. 概述

REDIS 模块的可运行 complete 配置。它从输入变量设置 Provider，并调用已发布的 Registry 模块。

## 2. 用法

```shell
terraform init
terraform plan
terraform apply
terraform plan
terraform destroy
```

## 3. 依赖要求

| 名称 | 版本 |
|---|---|
| Terraform | `>= 1.5.7` |
| OpenTofu | `>= 1.11.8` |

## 4. Providers

| 名称 | 来源 |
|---|---|
| `volcenginecc` | `volcengine/volcenginecc` |

## 5. 资源

| 名称 | 说明 |
|---|---|
| `terraform-volcenginecc-modules/redis/volcenginecc` | 已发布的 REDIS 模块。 |

## 6. 输入

| 名称 | 说明 |
|---|---|
| `instance_name` | 模块定义的 instance_name。 |
| `region` | 模块定义的 region。 |
| `vpc_id` | 模块定义的 vpc_id。 |
| `subnet_id` | 模块定义的 subnet_id。 |
| `availability_zones` | 模块定义的 availability_zones。 |
| `application_cidr` | 模块定义的 application_cidr。 |
| `password` | 模块定义的 password。 |

## 7. 输出

| 名称 | 说明 |
|---|---|
| `instance_id` | 模块定义的 instance_id。 |
| `private_address` | 模块定义的 private_address。 |
| `maintenance_time` | 模块定义的 maintenance_time。 |
| `security_group_id` | 模块定义的 security_group_id。 |

## 8. 示例

本目录即为 complete 示例。

## 9. 说明

- 请通过 Provider 支持的配置提供凭据，绝不应写入源文件。
- apply 后的最终 plan 必须报告无变更，才能接受该配置。
