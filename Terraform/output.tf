
output "ubuntu_vms" {
  description = "Created Ubuntu VMs"
  value = {
    for i, vm in proxmox_virtual_environment_vm.ubuntu_vm :
    vm.name => try(
      element([
        for ip in flatten(vm.ipv4_addresses) :
        ip if ip != "127.0.0.1"
      ], 0),
      "No IP found"
    )
  }
}

output "centos_vms" {
  description = "Created CentOS VMs"
  value = {
    for i, vm in proxmox_virtual_environment_vm.centos_vm :
    vm.name => try(
      element([
        for ip in flatten(vm.ipv4_addresses) :
        ip if ip != "127.0.0.1"
      ], 0),
      "No IP found"
    )
  }
}