# --------------------------------------------------------------------
# Ensure Ubuntu template exists
# --------------------------------------------------------------------
resource "null_resource" "ensure_template" {
  provisioner "remote-exec" {
    inline = [
      "if ! pveam list local | grep -q ubuntu-24.04-standard_24.04-2_amd64.tar.zst; then",
      "  pveam update",
      "  pveam download local ubuntu-24.04-standard_24.04-2_amd64.tar.zst",
      "fi"
    ]

    connection {
      type     = "ssh"
      host     = var.proxmox_ip
      user     = "root"
      password = var.proxmox_password
    }
  }

  triggers = {
    template = "ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
  }
}

resource "proxmox_virtual_environment_container" "container" {
  depends_on   = [null_resource.ensure_template]
  node_name = var.proxmox_node

  unprivileged = true

  initialization {
    hostname = var.hostname

    user_account {
      password = var.root_password
    }
    ip_config {
      ipv4 {
        address = var.network_ip_mode == "dhcp" ? "dhcp" : var.network_ip_address
        gateway = var.network_ip_mode == "dhcp" ? null : var.network_gateway
      }
    }
  }

  cpu {
    cores = var.cores
  }

  memory {
    dedicated = var.memory
  }

  disk {
    datastore_id = var.storage
    size         = var.disk_size
  }

  network_interface {
    name   = "eth0"
    bridge = var.network_bridge
    vlan_id = var.network_vlan
  }

  operating_system {
    template_file_id = var.template
    type            = "ubuntu"
  }

  features {
    nesting = true
  }

  started = true
}

output "container_id" {
  description = "The VMID of the created container"
  value       = proxmox_virtual_environment_container.container.vm_id
}
