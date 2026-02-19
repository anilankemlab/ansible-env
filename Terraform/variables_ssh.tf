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

variable "additional_ssh_public_key" {
  description = "Additional SSH public key to add to the VM (e.g. for user access)"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC3WFjIYYt/8X6DdxPwnfeq5zlMu90SfYT781koCqOZ/lRvzolcjsYpDPmZbD2Lg3WTtLHSSCBK3/Qar5LHWj9JJlLj6F2B13GF1SNUawwE3aBEbwj1eoO4fnJJtfpOuSO869qzP5//okfnSIp+htL+UHWlDOg4aclcNhDxe/C5nDwMIVeX0h8P8HfZWPTHzTrRQW6Uh0U3YqAK0+MOFrYm17F3Y6ug6oMU30E3XBCro9TIiArtXy3ht1flWRYo/XlTe78UtEkDsB/ffi9XKF3o0XAP7g+77p0wTCh9CtPl3p/umriIVgZbbMl9+UNYz4ZHRLeE0nWzALBzo0rbG9L+y4Z4ml47bzSsD1/q93A3Zj9QSfL4Xc7sRbde2sg+eZJ7SG/bBqXMcSuJ+GYy/YSm0JEO24a3RM1yYnUkbJr0bKDkyWxtziLJ0J6LkNyNxBvc5aG9w9lDUDP5NUJSL5GnBpl44ryy8DYZjoxN/id5/re0v5HFbpFXr1PumVVu3Q9UeH34ZUEGqbiBPauNJMA4r4zqcPR0ayMCO9rYP/Ni8iz93OUBVyaHc8DOL4cWgk4NTI8uV90Yg02cGRB7ZvHdiyy7u46uBn1PM+UU+dpADpg7Y6oEw7y3Dh+UMgYNXqDUfsnV+UPpFNvGdTO+FwOMb8GlRZAvIRxqo5edTD3xMQ== root@Ansible" # Optional
}
