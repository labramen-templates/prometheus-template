variable "proxmox_api_url" {
  description = "Proxmox API URL"
  type        = string
}

variable "proxmox_user" {
  description = "Proxmox username"
  type        = string
}

variable "proxmox_password" {
  description = "Proxmox password"
  type        = string
  sensitive   = true
}

variable "proxmox_ip" {
  description = "Proxmox IP address"
  type        = string
}

variable "proxmox_node" {
  description = "Proxmox node name"
  type        = string
}

variable "hostname" {
  description = "Container hostname"
  type        = string
}

variable "template" {
  description = "LXC template name"
  type        = string
  default     = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
}

variable "cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Memory in MB"
  type        = number
  default     = 2048
}

variable "disk_size" {
  description = "Disk size (e.g., 12)"
  type        = number
  default     = 12
}

variable "storage" {
  description = "Storage location for container"
  type        = string
  default     = "local-lvm"
}

variable "network_bridge" {
  description = "Network bridge"
  type        = string
  default     = "vmbr0"
}

variable "network_vlan" {
  description = "VLAN ID (optional, omit for no VLAN tagging)"
  type        = number
  default     = null
}

variable "network_ip_mode" {
  description = "IP address mode: 'dhcp' or 'static'"
  type        = string
  default     = "dhcp"

  validation {
    condition     = contains(["dhcp", "static"], var.network_ip_mode)
    error_message = "IP mode must be either 'dhcp' or 'static'"
  }
}

variable "network_ip_address" {
  description = "Static IP address with CIDR (e.g., '10.0.1.50/24'). Only used if network_ip_mode is 'static'"
  type        = string
  default     = null
}

variable "network_gateway" {
  description = "Network gateway IP. Only used if network_ip_mode is 'static'"
  type        = string
  default     = null
}

variable "root_password" {
  description = "Root password for container"
  type        = string
  sensitive   = true
}

variable "ssh_public_keys" {
  description = "SSH public keys to add to container"
  type        = string
  default     = ""
}
