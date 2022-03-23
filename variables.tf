#################
# Dbfs service-linked roles(SLR)
#################
variable "create_service_linked_role" {
  description = "Controls if service linked role should be created"
  type        = bool
  default     = false
}

variable "product_name" {
  description = "(Required, ForceNew) The product name for SLR. Dbfs can automatically create the following service-linked roles: AliyunServiceRoleForDbfs."
  type        = string
  default     = ""
}

#################
# DBFS Instance
#################
variable "create_instance" {
  description = "Controls if instance should be created"
  type        = bool
  default     = false
}

variable "zone_id" {
  description = "(Required, ForceNew) The Zone ID of the Database file system."
  type        = string
  default     = ""
}

variable "performance_level" {
  description = "(ForceNew) The performance level of the Database file system. Valid values: PL0, PL1, PL2, PL3."
  type        = string
  default     = "PL1"

  validation {
    condition     = contains(["PL0", "PL1", "PL2", "PL3"], var.performance_level)
    error_message = "Allowed values are PL0, PL1, PL2 or PL3."
  }
}

variable "instance_name" {
  description = "(Required) The name of the Database file system."
  type        = string
  default     = ""
}

variable "size" {
  description = "(Required) The size Of the Database file system. Unit: GiB."
  type        = number
  default     = null
}

#################
# DBFS Instance Attachment
#################
variable "create_instance_attachment" {
  description = "Controls if instance attachment should be created"
  type        = bool
  default     = false
}

variable "ecs_id" {
  description = "(Required, ForceNew) The ID of the ECS instance."
  type        = string
  default     = ""
}

#################
#  DBFS Snapshot
#################
variable "create_snapshot" {
  description = "Controls if snapshot should be created"
  type        = bool
  default     = false
}

variable "instance_id" {
  description = "The id of dbfs instance."
  type        = string
  default     = ""
}

variable "snapshot_name" {
  description = "(ForceNew) The display name of the snapshot. The length is 2 to 128 characters. It must start with a large or small letter or Chinese, and cannot start with http:// and https://. It can contain numbers, colons (:), underscores (_), or hyphens (-). To prevent name conflicts with automatic snapshots, you cannot start with auto."
  type        = string
  default     = ""
}

variable "description" {
  description = "(ForceNew) Description of the snapshot. The description must be 2 to 256 characters in length. It must start with a letter, and cannot start with http:// or https://."
  type        = string
  default     = ""
}

variable "retention_days" {
  description = "(ForceNew) The retention time of the snapshot. Unit: days. Snapshots are automatically released after the retention time expires. Valid values: 1 to 65536."
  type        = number
  default     = null
}

variable "force" {
  description = "Whether to force deletion of snapshots."
  type        = bool
  default     = null
}
