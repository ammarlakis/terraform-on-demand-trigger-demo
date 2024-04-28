# Terraform On-Demand Trigger Demo
This repository demonstrates a specific issue encountered with dynamic updates in Terraform and provides a solution leveraging the features introduced in Terraform >= 1.4.

# The Issue
In cloud provisioning scenarios—such as deploying EC2 instances, it's often easier to dynamically fetching the latest available version of a resource. This is typically achieved using a data block or fetching the recommended version from AWS Systems Manager (SSM). The challenge arises because these updates are not under direct control: re-applying the Terraform configuration, even without changes, might inadvertently trigger an update if a new version becomes available. This behavior can lead to unintended deployments and configuration drift.

# The Solution
Terraform 1.4 introduces the `terraform_data` resource, which can be considered an enhanced version of the traditional `null_resource`. A key feature of the `terraform_data` resource is its ability to store any value within the Terraform state. Like `null_resource`, `terraform_data` is a resource object, which allows for the use of lifecycle policies to control its value. Specifically, one can use `ignore_changes` to prevent updates to the input, while updating its value can be managed through the `replace_triggered_by`, which conditions the recreation of the resource on changes to a manually adjustable value. This approach provides a controlled environment for managing updates, ensuring that changes are deliberate and predictable.
