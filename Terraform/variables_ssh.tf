variable "proxmox_ssh_username" {
  description = "Username for SSH connection to Proxmox"
  type        = string
  default     = "root"
}

variable "proxmox_ssh_private_key" {
  description = "Private key for SSH connection to Proxmox"
  type        = string
  sensitive   = true
}
