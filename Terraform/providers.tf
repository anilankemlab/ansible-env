
terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
    }
  }
}

variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token" {
  type = string
  sensitive = true
}



provider "proxmox" {
  endpoint = var.proxmox_api_url
  api_token = var.proxmox_api_token
  insecure = true
}

