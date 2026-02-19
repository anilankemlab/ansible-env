variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token" {
  type      = string
  sensitive = true
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


variable "ubuntu_count" {
  description = "Number of Ubuntu VMs to create (max 5)"
  type        = number
  default     = 1
  validation {
    condition     = var.ubuntu_count <= 5
    error_message = "Max 5 Ubuntu VMs allowed."
  }
}

variable "centos_count" {
  description = "Number of CentOS VMs to create (max 5)"
  type        = number
  default     = 1
  validation {
    condition     = var.centos_count <= 5
    error_message = "Max 5 CentOS VMs allowed."
  }
}

variable "ubuntu_template" {
  description = "Name of the Ubuntu Proxmox VM template"
  type        = string
  default     = "ubuntu24-golden"
}

variable "centos_template" {
  description = "Name of the CentOS Proxmox VM template"
  type        = string
  default     = "centos10-stream-golden"
}

variable "ubuntu_ip_start" {
  description = "Starting last octet for Ubuntu IPs"
  type        = number
  default     = 30
}

variable "centos_ip_start" {
  description = "Starting last octet for CentOS IPs"
  type        = number
  default     = 35
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