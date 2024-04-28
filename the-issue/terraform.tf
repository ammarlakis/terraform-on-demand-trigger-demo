# A random id that's always updated on each run
# It represents dynamically fetched values like the latest version of an ami
resource "random_id" "random" {
  byte_length = 8
  keepers = {
    "always" = timestamp()
  }
}


# The resource that will be created using the dynamically fetched value
resource "terraform_data" "object-to-be-created" {
  input = random_id.random
}
