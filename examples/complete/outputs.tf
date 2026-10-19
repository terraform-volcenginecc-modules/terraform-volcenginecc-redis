output "instance_id" {
  value = module.redis.instance_id
}

output "private_address" {
  value = module.redis.private_address
}

output "maintenance_time" {
  value = module.redis.maintenance_time
}

output "security_group_id" {
  value = volcenginecc_vpc_security_group.application.security_group_id
}
