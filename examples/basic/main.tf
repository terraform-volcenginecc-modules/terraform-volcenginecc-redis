provider "volcenginecc" {
  region = var.region
}

module "redis" {
  source  = "terraform-volcenginecc-modules/redis/volcenginecc"
  version = "~> 1.0"

  instance_name      = var.instance_name
  vpc_id             = var.vpc_id
  subnet_id          = var.subnet_id
  availability_zones = [var.availability_zone]
  engine_version     = "5.0"
  node_number        = 1
  # Verified in cn-beijing with Redis 5.0. Smaller 256 MiB SKUs are not sold
  # for this topology and are rejected by the Cloud Control API.
  shard_capacity_mib = 8192
  password           = var.password

  deletion_protection = false

  allow_lists = {
    application = {
      name       = "${var.instance_name}-application"
      allow_list = var.application_cidr
    }
  }

  tags = {
    Environment = "example"
    Scenario    = "session-cache"
  }
}
