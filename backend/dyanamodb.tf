module "dynamodb_table" {
  source                       = "git::https://github.com/cloudposse/terraform-aws-dynamodb.git?ref=master"
  namespace                    = "${var.namespace}"
  stage                        = "${var.stage}"
  name                         = "${var.name}-tf-lock"
  hash_key                     = "LockID"
  hash_key_type                = "S"
  enable_autoscaler            = false

  dynamodb_attributes = [
    {
      name = "LockID"
      type = "S"
    },
  ]
}
