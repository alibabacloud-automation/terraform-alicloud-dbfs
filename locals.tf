locals {
  # Get ID of dbfs resources
  this_instance_id = var.create_instance ? concat(alicloud_dbfs_instance.instance.*.id, [""])[0] : var.instance_id
}