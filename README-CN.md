Terraform module which creates DBFS resources on Alibaba Cloud.

terraform-alicloud-dbfs
=====================================================================

[English](https://github.com/terraform-alicloud-modules/terraform-alicloud-dbfs/blob/main/README.md) | 简体中文

本 Module 用于自动化管理数据库文件存储，包括实例、快照以及服务授权访问等，包含：`DBFS`。

本 Module 支持创建以下资源:

* [alicloud_dbfs_service_linked_role](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dbfs_service_linked_role)
* [alicloud_dbfs_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dbfs_instance)
* [alicloud_dbfs_instance_attachment](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dbfs_instance_attachment)
* [alicloud_dbfs_snapshot](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dbfs_snapshot)

## 用法

```hcl
module "example" {
  source = "terraform-alicloud-modules/dbfs/alicloud"
  #alicloud_dbfs_service_linked_role
  create_service_linked_role = true
  product_name               = "AliyunServiceRoleForDbfs"
  #alicloud_dbfs_instance
  create_instance   = true
  category          = "standard"
  zone_id           = "cn-beijing-k"
  performance_level = "PL1"
  instance_name     = "tf-test-dbfs"
  size              = 100
  #alicloud_dbfs_instance_attachment
  create_instance_attachment = true
  ecs_id                     = "your_ecs_id"
  #alicloud_dbfs_snapshot
  create_snapshot   = true
  snapshot_name     = "tf-test-dbfs"
  description       = "tf-test-dbfs"
  retention_days    = 30
  force             = false
}
```

## 示例

* [DBFS 完整示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-dbfs/tree/main/examples/complete)

## 注意事项

* 本 Module 使用的 AccessKey 和 SecretKey 可以直接从 `profile` 和 `shared_credentials_file`
  中获取。如果未设置，可通过下载安装 [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) 后进行配置.

## 要求

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | > = 0.13 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | > = 1.157.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | > = 1.157.0 |

## 提交问题

如果在使用该 Terraform Module
的过程中有任何问题，可以直接创建一个 [Provider Issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new)，我们将根据问题描述提供解决方案。

**注意:** 不建议在该 Module 仓库中直接提交 Issue。

## 作者

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## 许可

MIT Licensed. See LICENSE for full details.

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)
