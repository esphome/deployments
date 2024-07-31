terraform {
  cloud {
    organization = "esphome"

    workspaces {
      name = "firmware_hosting"
    }
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }
}
