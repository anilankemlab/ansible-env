data "proxmox_virtual_environment_vms" "template" {
  node_name = var.node_name

   filter {
    name   = "name"
    values = [var.template_name]
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


    user_account {
      username = "anilankem"
      password = "anilankem"
      keys = [
        file("~/.ssh/id_ed25519.pub"),
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC3WFjIYYt/8X6DdxPwnfeq5zlMu90SfYT781koCqOZ/lRvzolcjsYpDPmZbD2Lg3WTtLHSSCBK3/Qar5LHWj9JJlLj6F2B13GF1SNUawwE3aBEbwj1eoO4fnJJtfpOuSO869qzP5//okfnSIp+htL+UHWlDOg4aclcNhDxe/C5nDwMIVeX0h8P8HfZWPTHzTrRQW6Uh0U3YqAK0+MOFrYm17F3Y6ug6oMU30E3XBCro9TIiArtXy3ht1flWRYo/XlTe78UtEkDsB/ffi9XKF3o0XAP7g+77p0wTCh9CtPl3p/umriIVgZbbMl9+UNYz4ZHRLeE0nWzALBzo0rbG9L+y4Z4ml47bzSsD1/q93A3Zj9QSfL4Xc7sRbde2sg+eZJ7SG/bBqXMcSuJ+GYy/YSm0JEO24a3RM1yYnUkbJr0bKDkyWxtziLJ0J6LkNyNxBvc5aG9w9lDUDP5NUJSL5GnBpl44ryy8DYZjoxN/id5/re0v5HFbpFXr1PumVVu3Q9UeH34ZUEGqbiBPauNJMA4r4zqcPR0ayMCO9rYP/Ni8iz93OUBVyaHc8DOL4cWgk4NTI8uV90Yg02cGRB7ZvHdiyy7u46uBn1PM+UU+dpADpg7Y6oEw7y3Dh+UMgYNXqDUfsnV+UPpFNvGdTO+FwOMb8GlRZAvIRxqo5edTD3xMQ== root@Ansible"
      ]
      sudo = true

    }

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