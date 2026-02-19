variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token" {
  type      = string
  sensitive = true
}


variable "ip_address" {
  description = "Static IP address (optional)"
  type        = string
  default     = ""
}

variable "gateway" {
  description = "Default gateway"
  type        = string
  default     = "192.168.1.1"
}

variable "cidr" {
  description = "CIDR prefix"
  type        = number
  default     = 24
}


variable "node_name" {
  description = "Proxmox node where the VM will run"
  type        = string
  default = "proxmox"
}

variable "vm_name" {
  description = "Name of the VM to create"
  type        = string
}

variable "template_name" {
  description = "Name of the Proxmox VM template to clone from (centos10-stream-golden) or (ubuntu24-golden)"
  type        = string
  default     = "ubuntu24-golden"
}

variable "full_clone" {
  description = "Whether to perform a full clone instead of a linked clone"
  type        = bool
  default     = true
}

variable "vm_cores" {
  description = "Number of vCPUs for the VM"
  type        = number
  default     = 2
}

variable "vm_memory_mb" {
  description = "Amount of RAM for the VM in megabytes"
  type        = number
  default     = 2048
}

variable "disk_size_gb" {
  description = "Disk size for the VM in gigabytes"
  type        = number
  default = 20
}

variable "disk_storage" {
  description = "Proxmox storage ID used for the VM disk (e.g. local-lvm)"
  type        = string
  default     = "local-lvm"
}

variable "vm_tags" {
  description = "Optional tags to apply to the VM"
  type        = list(string)
  default     = []
}