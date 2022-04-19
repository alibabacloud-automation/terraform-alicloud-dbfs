resource "alicloud_dbfs_service_linked_role" "service_linked_role" {
  count        = var.create_service_linked_role ? 1 : 0
  product_name = var.product_name
}

resource "alicloud_dbfs_instance" "instance" {
  count             = var.create_instance ? 1 : 0
  instance_name     = var.instance_name
  category          = var.category
  zone_id           = var.zone_id
  performance_level = var.performance_level
  size              = var.size
}

resource "alicloud_dbfs_instance_attachment" "attachment" {
  count       = var.create_instance_attachment ? 1 : 0
  instance_id = local.this_instance_id
  ecs_id      = var.ecs_id
}

resource "alicloud_dbfs_snapshot" "snapshot" {
  count          = var.create_snapshot ? 1 : 0
  snapshot_name  = var.snapshot_name
  instance_id    = local.this_instance_id
  description    = var.description
  retention_days = var.retention_days
  force          = var.force
  depends_on     = [alicloud_dbfs_instance_attachment.attachment]
}