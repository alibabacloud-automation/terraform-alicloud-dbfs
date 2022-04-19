output "service_linked_role_id" {
  value = concat(alicloud_dbfs_service_linked_role.service_linked_role.*.id, [""])[0]
}

output "instance_id" {
  value = concat(alicloud_dbfs_instance.instance.*.id, [""])[0]
}

output "instance_attachment_id" {
  value = concat(alicloud_dbfs_instance_attachment.attachment.*.id, [""])[0]
}

output "instance_attachment_status" {
  value = concat(alicloud_dbfs_instance_attachment.attachment.*.status, [""])[0]
}

output "snapshot_id" {
  value = concat(alicloud_dbfs_snapshot.snapshot.*.id, [""])[0]
}