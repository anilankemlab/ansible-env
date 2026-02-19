output "vm_id" {
  description = "The VM ID of the created VM"
  value       = proxmox_virtual_environment_vm.vm_from_template.vm_id
}

output "vm_name" {
  description = "The name of the created VM"
  value       = proxmox_virtual_environment_vm.vm_from_template.name
}

output "vm_node" {
  description = "Proxmox node where VM is created"
  value       = proxmox_virtual_environment_vm.vm_from_template.node_name
}

output "vm_ip" {
  value = try(
    element([
      for ip in flatten(proxmox_virtual_environment_vm.vm_from_template.ipv4_addresses) :
      ip if ip != "127.0.0.1"
    ], 0),
    null
  )
}