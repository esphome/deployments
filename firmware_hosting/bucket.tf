resource "cloudflare_r2_bucket" "bucket" {
  name       = var.bucket_name
  account_id = var.cloudflare_account_id
}
