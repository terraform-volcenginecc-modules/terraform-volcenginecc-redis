# terraform-volcenginecc-redis 验证报告

## 一、验证对象与环境

| 项目 | 内容 |
| --- | --- |
| 模块 | `terraform-volcenginecc-redis` |
| 示例 | `examples/basic` |
| 部署地域 | `cn-beijing` |
| Provider | `volcengine/volcenginecc v0.0.72` |
| 模块来源 | 本地路径 `../..` |
| Cloud Control 服务 | 线上 `cloudcontrol` |

凭据通过环境变量传入。报告不记录 AccessKey、SecretAccessKey 或 Redis 密码。

## 二、验证结果

### 2.1 单节点 Redis 与私网白名单

验证对象为单节点 Redis（Standalone）和关联私网 CIDR 白名单。

| 验证项 | 结果 |
| --- | --- |
| `terraform init -upgrade` | 通过 |
| `terraform validate` | 通过 |
| 首次 `terraform plan` | 通过，新增 2 个资源 |
| `terraform apply` | 通过 |
| 实例回读 | 通过，实例类型为 `Standalone`、节点数为 1 |
| 私网连接输出 | 通过 |
| 二次 `terraform plan -detailed-exitcode` | 通过，`No changes`，退出码 0 |
| `terraform destroy` | 通过，Redis 实例和白名单均已删除 |
| `terraform state list` | 为空 |

## 三、结论

线上 Cloud Control 已支持单节点 Redis 创建、回读和删除。单节点场景不配置备份能力；备份配置仅适用于支持备份的主从或集群实例。

## 四、线上成功调用参数与执行输出

以下为最近一次线上验证的实际调用参数。敏感凭据和密码已脱敏。

```hcl
# Redis 实例：Volcengine::Redis::Instance
region             = "cn-beijing"
instance_name      = "redis-basic-online-1792117491"
vpc_id             = "vpc-btoy1n92n11c5h0b2ul0jz9c"
subnet_id          = "subnet-1a1nd7d2m67sw8nvepjx9sbai"
availability_zones = ["cn-beijing-a"]

engine_version     = "5.0"
node_number        = 1
shard_capacity_mib = 8192
sharded_cluster    = false
multi_az           = false

charge_type         = "PostPaid"
deletion_protection = false
no_auth_mode        = "close"
password            = "<敏感值>"

# 单节点不传备份字段。
continuous_backup = null
create_backup     = null

tags = {
  Environment = "example"
  Scenario    = "session-cache"
}
```

```hcl
# Redis 白名单：Volcengine::Redis::AllowList
allow_list_name     = "redis-basic-online-1792117491-application"
allow_list          = "192.168.19.0/24"
allow_list_category = "Ordinary"
instance_ids        = ["<Redis 实例创建后返回的 InstanceId>"]
```

实际执行摘要：

```text
Provider: volcengine/volcenginecc v0.0.72
Plan: 2 to add, 0 to change, 0 to destroy.

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
instance_id = "redis-cnlfzw4wunabau7bt"
private_address = "redis-cnlfzw4wunabau7bt.redis.ivolces.com"
private_port = "6379"
instance_class = "Standalone"
node_number = 1

No changes. Your infrastructure matches the configuration.

Destroy complete! Resources: 2 destroyed.
terraform state list: <empty>
```
