provider "alicloud" {
  region = "cn-hangzhou"
}
locals {
  zone_id = "cn-hangzhou-i"
}

data "alicloud_images" "default" {
  name_regex  = "^aliyun_2_1903_x64_20G_alibase_20240628.vhd"
  owners      = "system"
  most_recent = true
}

data "alicloud_instance_types" "default" {
  instance_type_family = "ecs.g7se"
  availability_zone    = local.zone_id
}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
}
data "alicloud_vswitches" "default" {
  vpc_id  = data.alicloud_vpcs.default.ids[0]
  zone_id = local.zone_id
}

module "security_group" {
  source = "alibaba/security-group/alicloud"
  vpc_id = data.alicloud_vpcs.default.ids[0]
}

module "ecs_instance" {
  source = "alibaba/ecs-instance/alicloud"

  number_of_instances = 1

  instance_type        = data.alicloud_instance_types.default.instance_types.0.id
  image_id             = data.alicloud_images.default.images.0.id
  vswitch_ids          = [data.alicloud_vswitches.default.ids.0]
  security_group_ids   = [module.security_group.this_security_group_id]
  system_disk_category = "cloud_essd"

}

module "dbfs_service_linked_role" {
  source = "../.."

  #alicloud_dbfs_service_linked_role
  create_service_linked_role = true
  product_name               = "AliyunServiceRoleForDbfs"

  #alicloud_dbfs_instance
  create_instance = false

  #alicloud_dbfs_instance_attachment
  create_instance_attachment = false

  #alicloud_dbfs_snapshot
  create_snapshot = false

}

module "dbfs_instance" {
  source = "../.."

  #alicloud_dbfs_service_linked_role
  create_service_linked_role = false

  #alicloud_dbfs_instance
  create_instance = true

  instance_name     = var.instance_name
  category          = "standard"
  zone_id           = local.zone_id
  performance_level = "PL1"
  size              = var.size

  #alicloud_dbfs_instance_attachment
  create_instance_attachment = false

  #alicloud_dbfs_snapshot
  create_snapshot = false


}

module "dbfs_instance_attachment_and_snapshot" {
  source = "../.."

  #alicloud_dbfs_service_linked_role
  create_service_linked_role = false

  #alicloud_dbfs_instance
  create_instance = false

  #alicloud_dbfs_instance_attachment
  create_instance_attachment = true

  instance_id = module.dbfs_instance.instance_id
  ecs_id      = module.ecs_instance.this_instance_id[0]

  #alicloud_dbfs_snapshot
  create_snapshot = true

  snapshot_name  = "tf-testacc-snapshot-name"
  description    = "tf-testacc-description"
  retention_days = 1
  force          = var.force

}
