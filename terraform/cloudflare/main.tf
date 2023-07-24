terraform {
#  cloud {
#    hostname     = "app.terraform.io"
#    organization = "Xorix"
#    workspaces {
#      name = "arpa-home-cloudflare"
#    }
#  }
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.6.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.3.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = "0.7.2"
    }
  }
  required_version = ">= 1.3.0"
}

data "sops_file" "secrets" {
  source_file = "secret.sops.yaml"
}


data "http" "ipv4" {
  url = "http://ipv4.icanhazip.com"
}