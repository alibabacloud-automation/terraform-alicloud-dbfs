output "service_linked_role_id" {
  value = module.dbfs_service_linked_role.service_linked_role_id
}

output "instance_id" {
  value = module.dbfs_instance.instance_id
}

output "instance_attachment_id" {
  value = module.dbfs_instance_attachment_and_snapshot.instance_attachment_id
}

output "instance_attachment_status" {
  value = module.dbfs_instance_attachment_and_snapshot.instance_attachment_status
}

output "snapshot_id" {
  value = module.dbfs_instance_attachment_and_snapshot.snapshot_id
}