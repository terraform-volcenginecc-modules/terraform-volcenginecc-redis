provider "volcenginecc" {
  region = var.region
}

resource "volcenginecc_vpc_security_group" "application" {
  vpc_id              = var.vpc_id
  security_group_name = "${var.instance_name}-application"
  description         = "Temporary security group created by the complete Redis example."
}

module "redis" {
  source  = "terraform-volcenginecc-modules/redis/volcenginecc"
  version = "~> 1.0"

  instance_name      = var.instance_name
  vpc_id             = var.vpc_id
  subnet_id          = var.subnet_id
  availability_zones = var.availability_zones
  engine_version     = "5.0"
  node_number        = 2
  shard_capacity_mib = 8192
  password           = var.password

  deletion_protection = false
  continuous_backup   = true
  create_backup       = true

  parameter_group = {
    name        = "${var.instance_name}-parameters"
    description = "Application-specific eviction and idle client settings."
    parameters = [
      {
        name  = "maxmemory-policy"
        value = "allkeys-lru"
      }
    ]
  }

  allow_lists = {
    application_security_group = {
      name       = "${var.instance_name}-application-sg"
      allow_list = var.application_cidr
      security_group_bind_infos = [
        {
          bind_mode         = "IngressDirectionIp"
          security_group_id = volcenginecc_vpc_security_group.application.security_group_id
        }
      ]
    }
  }

  tags = {
    Environment = "example"
    Scenario    = "leaderboard-and-queue"
  }
}
