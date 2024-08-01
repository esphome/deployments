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
    github = {
      source  = "integrations/github"
      version = "6.2.3"
    }
  }
}

provider "github" {
  owner = var.github_organization
}
