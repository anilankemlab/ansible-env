
data "proxmox_virtual_environment_vms" "ubuntu_template" {
  node_name = var.node_name
  filter {
    name   = "name"
    values = [var.ubuntu_template]
  }
}

data "proxmox_virtual_environment_vms" "centos_template" {
  node_name = var.node_name
  filter {
    name   = "name"
    values = [var.centos_template]
  }
}

# Ubuntu Cloud-Init
resource "proxmox_virtual_environment_file" "ubuntu_cloud_config" {
  count        = var.ubuntu_count
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.node_name

  source_raw {
    data = templatefile("cloud-init.tftpl", {
      hostname  = "ubuntu-${count.index + 1}"
      ssh_key_1 = file("~/.ssh/id_ed25519.pub")
      ssh_key_2 = var.additional_ssh_public_key
    })
    file_name = "cloud-init-ubuntu-${count.index + 1}.yaml"
  }
}

# CentOS Cloud-Init
resource "proxmox_virtual_environment_file" "centos_cloud_config" {
  count        = var.centos_count
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.node_name

  source_raw {
    data = templatefile("cloud-init.tftpl", {
      hostname  = "centos-${count.index + 1}"
      ssh_key_1 = file("~/.ssh/id_ed25519.pub")
      ssh_key_2 = var.additional_ssh_public_key
    })
    file_name = "cloud-init-centos-${count.index + 1}.yaml"
  }
}

# Ubuntu VMs
resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  count     = var.ubuntu_count
  name      = "ubuntu-${count.index + 1}"
  node_name = var.node_name
  tags      = var.vm_tags

  clone {
    vm_id = data.proxmox_virtual_environment_vms.ubuntu_template.vms[0].vm_id
    full  = var.full_clone
  }

  cpu {
    type  = "host"
    cores = var.vm_cores
  }

  startup {
    order = 1
  }

  memory {
    dedicated = var.vm_memory_mb
  }

  disk {
    datastore_id = var.disk_storage
    interface    = "scsi0"
    size         = var.disk_size_gb
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }

  agent {
    enabled = true
  }

  initialization {
    user_data_file_id = proxmox_virtual_environment_file.ubuntu_cloud_config[count.index].id

    ip_config {
      ipv4 {
        address = "192.168.1.${var.ubuntu_ip_start + count.index}/${var.cidr}"
        gateway = var.gateway
      }
    }
  }

  on_boot = true
}

# CentOS VMs
resource "proxmox_virtual_environment_vm" "centos_vm" {
  count     = var.centos_count
  name      = "centos-${count.index + 1}"
  node_name = var.node_name
  tags      = var.vm_tags

  clone {
    vm_id = data.proxmox_virtual_environment_vms.centos_template.vms[0].vm_id
    full  = var.full_clone
  }

  cpu {
    type  = "host"
    cores = var.vm_cores
  }

  startup {
    order = 1
  }

  memory {
    dedicated = var.vm_memory_mb
  }

  disk {
    datastore_id = var.disk_storage
    interface    = "scsi0"
    size         = var.disk_size_gb
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }

  agent {
    enabled = true
  }

  initialization {
    user_data_file_id = proxmox_virtual_environment_file.centos_cloud_config[count.index].id

    ip_config {
      ipv4 {
        address = "192.168.1.${var.centos_ip_start + count.index}/${var.cidr}"
        gateway = var.gateway
      }
    }
  }

  on_boot = true
}