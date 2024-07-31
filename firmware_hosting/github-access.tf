data "cloudflare_api_token_permission_groups" "all" {}

resource "cloudflare_api_token" "github-token" {
  name = "github-firmware-upload-token"
  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.r2["Workers R2 Storage Bucket Item Read"],
      data.cloudflare_api_token_permission_groups.all.r2["Workers R2 Storage Bucket Item Write"]
    ]
    resources = {
      "com.cloudflare.edge.r2.bucket.${var.cloudflare_account_id}_default_${var.bucket_name}" = "*"
    }
  }
}

resource "github_actions_organization_secret" "cloudflare-r2-upload-token" {
  secret_name     = "CLOUDFLARE_R2_UPLOAD_TOKEN"
  visibility      = "selected"
  plaintext_value = cloudflare_api_token.github-token.value

  lifecycle {
    ignore_changes = [selected_repository_ids]
  }
}
