provider "alicloud" {
  region = "cn-beijing"
}

locals {
  zone_id = "cn-beijing-k"
}

data "alicloud_images" "default" {
  owners      = "system"
  name_regex  = "^centos_8"
  most_recent = true
}

module "vpc" {
  source             = "alibaba/vpc/alicloud"
  create             = true
  vpc_name           = "tf-test-dbfs"
  vpc_cidr           = "172.16.0.0/16"
  vswitch_name       = "tf-test-dbfs"
  vswitch_cidrs      = ["172.16.0.0/21"]
  availability_zones = [local.zone_id]
}

module "security_group" {
  source = "alibaba/security-group/alicloud"
  vpc_id = module.vpc.this_vpc_id
}

resource "alicloud_instance" "default" {

  availability_zone    = local.zone_id
  security_groups      = [module.security_group.this_security_group_id]
  instance_type        = "ecs.g7se.large"
  image_id             = data.alicloud_images.default.images.0.id
  instance_name        = "tf-test-dbfs"
  vswitch_id           = module.vpc.this_vswitch_ids[0]
  system_disk_category = "cloud_essd"
}


module "example" {
  source = "../.."

  #alicloud_dbfs_service_linked_role
  create_service_linked_role = true
  product_name               = "AliyunServiceRoleForDbfs"

  #alicloud_dbfs_instance
  create_instance   = true
  zone_id           = local.zone_id
  performance_level = "PL1"
  instance_name     = var.instance_name
  size              = var.size

  #alicloud_dbfs_instance_attachment
  create_instance_attachment = true
  ecs_id                     = alicloud_instance.default.id


  #alicloud_dbfs_snapshot
  create_snapshot = true
  snapshot_name   = "tf-test-dbfs"
  description     = "tf-test-dbfs"
  retention_days  = 30
  force           = var.force

}