# A variable that is used to trigger the on-demand update
variable "on-demand-trigger" {
  type = any
  description = "A value that triggers an object update when changed."
  default = 1
}

# A random id that's always updated on each run
# It represents dynamically fetched values like the latest version of an ami.
resource "random_id" "random" {
  byte_length = 8
  keepers = {
    "always" = timestamp()
  }
}

# A value that's used to hold the variable value because `replace_triggered_by`
# doesn't accept variable value directly.
resource "terraform_data" "on-demand-trigger" {
  input = var.on-demand-trigger
}

# The resource that holds the dynamically fetched value 
# but only refresh it on demand.
resource "terraform_data" "value-holder" {
  input = random_id.random

  lifecycle {
    ignore_changes = [ input ]
    replace_triggered_by = [ terraform_data.on-demand-trigger ]
  }
}

# The resource that will be created using the dynamically fetched value
resource "terraform_data" "object-to-be-created" {
  input = terraform_data.value-holder.output
}
