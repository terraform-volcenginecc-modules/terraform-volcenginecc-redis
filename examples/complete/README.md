# COMPLETE REDIS Example

## 1. Overview

Runnable complete configuration for the REDIS module. It configures the provider from input variables and calls the published Registry module.

## 2. Usage

```shell
terraform init
terraform plan
terraform apply
terraform plan
terraform destroy
```

## 3. Requirements

| Name | Version |
|---|---|
| Terraform | `>= 1.5.7` |
| OpenTofu | `>= 1.11.8` |

## 4. Providers

| Name | Source |
|---|---|
| `volcenginecc` | `volcengine/volcenginecc` |

## 5. Resources

| Name | Description |
|---|---|
| `terraform-volcenginecc-modules/redis/volcenginecc` | Published REDIS module. |

## 6. Inputs

| Name | Description |
|---|---|
| `instance_name` | Module-defined instance_name. |
| `region` | Module-defined region. |
| `vpc_id` | Module-defined vpc_id. |
| `subnet_id` | Module-defined subnet_id. |
| `availability_zones` | Module-defined availability_zones. |
| `application_cidr` | Module-defined application_cidr. |
| `password` | Module-defined password. |

## 7. Outputs

| Name | Description |
|---|---|
| `instance_id` | Module-defined instance_id. |
| `private_address` | Module-defined private_address. |
| `maintenance_time` | Module-defined maintenance_time. |
| `security_group_id` | Module-defined security_group_id. |

## 8. Examples

This directory is the complete example.

## 9. Notes

- Supply credentials through supported provider configuration, never in source files.
- The final plan after apply must report no changes before the configuration is accepted.
