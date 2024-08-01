variable "bucket_name" {
  description = "The name of the R2 bucket"
  type        = string
}

variable "cloudflare_account_id" {
  description = "The account ID for the bucket"
  type        = string
}

variable "github_organization" {
  description = "The GitHub organization to create the secret in"
  type        = string
  default     = "esphome"
}
