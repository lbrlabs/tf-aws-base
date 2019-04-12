module "kms_key" {
  source                  = "git::https://github.com/cloudposse/terraform-aws-kms-key.git?ref=master"
  namespace               = "${var.namespace}"
  stage                   = "${var.stage}"
  name                    = "${var.name}-terraform-state"
  description             = "KMS key for Terraform State"
  deletion_window_in_days = 10
  enable_key_rotation     = "true"
  alias                   = "alias/terraform"
}

module "state_bucket" {
  source                   = "git::https://github.com/cloudposse/terraform-aws-s3-bucket.git?ref=master"
  enabled                  = "true"
  versioning_enabled       = "true"
  name                     = "${var.name}-terraform-state"
  stage                    = "${var.stage}"
  namespace                = "${var.namespace}"
  sse_algorithm            = "aws:kms"
  kms_master_key_id        = "${module.kms_key.key_id}"
}
