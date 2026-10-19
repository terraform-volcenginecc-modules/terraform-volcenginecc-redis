output "instance_id" {
  description = "ID of the Redis instance."
  value       = volcenginecc_redis_instance.this.instance_id
}

output "private_address" {
  description = "Private DNS address of the Redis instance."
  value       = volcenginecc_redis_instance.this.private_address
}

output "private_port" {
  description = "Private connection port returned by the cloud."
  value       = volcenginecc_redis_instance.this.private_port
}

output "vip" {
  description = "Private IPv4 address of the Redis instance."
  value       = volcenginecc_redis_instance.this.vip
}

output "private_connection" {
  description = "Private connection information returned by the cloud. It never includes passwords."
  value = {
    address = volcenginecc_redis_instance.this.private_address
    port    = volcenginecc_redis_instance.this.private_port
    vip     = volcenginecc_redis_instance.this.vip
  }
}

output "connection_addresses" {
  description = "All cloud-returned connection addresses. The Provider does not label primary and reader endpoints separately."
  value = [
    for address in volcenginecc_redis_instance.this.visit_addrs : {
      type    = address.addr_type
      address = address.address
      port    = address.port
      vip     = address.vip
    }
  ]
}

output "status" {
  description = "Current cloud status of the Redis instance."
  value       = volcenginecc_redis_instance.this.status
}

output "maintenance_time" {
  description = "Maintenance window returned by the cloud. The current Provider exposes this as read-only."
  value       = volcenginecc_redis_instance.this.maintenance_time
}

output "allow_list_ids" {
  description = "IDs of allowlists managed by this module, keyed by the input map key."
  value = {
    for key, allow_list in volcenginecc_redis_allow_list.this : key => allow_list.allow_list_id
  }
}

output "parameter_group_id" {
  description = "ID of the custom or external parameter group applied to the Redis instance."
  value       = local.parameter_group_id
}

output "account_names" {
  description = "Names of additional Redis accounts managed by this module."
  value = {
    for key, account in volcenginecc_redis_account.this : key => account.account_name
  }
}
