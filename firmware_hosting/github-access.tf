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

resource "github_actions_organization_secret" "cloudflare-r2-account-id" {
  secret_name     = "CLOUDFLARE_R2_ACCOUNT_ID"
  visibility      = "selected"
  plaintext_value = var.cloudflare_account_id

  lifecycle {
    ignore_changes = [selected_repository_ids]
  }
}

resource "github_actions_organization_secret" "cloudflare-r2-bucket" {
  secret_name     = "CLOUDFLARE_R2_BUCKET"
  visibility      = "selected"
  plaintext_value = var.bucket_name

  lifecycle {
    ignore_changes = [selected_repository_ids]
  }
}

resource "github_actions_organization_secret" "cloudflare-r2-access-key-id" {
  secret_name     = "CLOUDFLARE_R2_ACCESS_KEY_ID"
  visibility      = "selected"
  plaintext_value = cloudflare_api_token.github-token.id

  lifecycle {
    ignore_changes = [selected_repository_ids]
  }
}

resource "github_actions_organization_secret" "cloudflare-r2-secret-access-key" {
  secret_name     = "CLOUDFLARE_R2_SECRET_ACCESS_KEY"
  visibility      = "selected"
  plaintext_value = sha256(cloudflare_api_token.github-token.value)

  lifecycle {
    ignore_changes = [selected_repository_ids]
  }
}
