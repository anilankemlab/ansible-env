data "proxmox_virtual_environment_vms" "template" {
  node_name = var.node_name

   filter {
    name   = "name"
    values = [var.template_name]
  }
}


resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.node_name

  source_raw {
    data = templatefile("cloud-init.tftpl", {
      ssh_key_1 = file("~/.ssh/id_ed25519.pub")
      ssh_key_2 = var.additional_ssh_public_key
    })
    file_name = "cloud-init-${var.vm_name}.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "vm_from_template" {

  name      = var.vm_name
  node_name = var.node_name

  tags = var.vm_tags

  clone {
    vm_id = data.proxmox_virtual_environment_vms.template.vms[0].vm_id
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
    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id

    ip_config {

      ipv4 {
        # If an IP address is provided, use static configuration; otherwise, use DHCP
        address = (
          var.ip_address != null && var.ip_address != ""
        ) ? "${var.ip_address}/${var.cidr}" : "dhcp"

        gateway = (
          var.ip_address != null && var.ip_address != ""
        ) ? var.gateway : null
      }

    }

  }

  # operating_system {
  #   type = "l26"
  # }

  on_boot = true
}