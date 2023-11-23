terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.11"
    }
  }
}

provider "proxmox" {

pm_debug = true
pm_api_url = "https://192.168.100.100:8006/api2/json"
pm_api_token_id = "terraformuser@pam!terraformuser_token"
pm_api_token_secret = "ebc81d5f-1e2d-4006-838f-b45fa770e7d6"
pm_tls_insecure = true
pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
    }
}


resource "proxmox_vm_qemu" "vms-pps" {

  count       = length(var.proxmox_nodes)
  name        = "k8spps${count.index+1}"
  desc        = "k8s pps"
  vmid 	      = "70${count.index+1}"
  target_node = var.proxmox_nodes[count.index]
  clone       = var.template_name
  agent       = 1
  os_type     = "cloud-init"
  cores       = 8
  sockets     = 1
  cpu         = "host"
  memory      = 8192 
  onboot      = true
  scsihw      = "virtio-scsi-single"
  bootdisk    = "scsi0"

  disk {
    size     = "20G"
    type     = "scsi"
    storage  = "local-lvm"
    iothread = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }
  
  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0   = "ip=192.168.100.17${count.index+1}/24,gw=192.168.100.1"
  nameserver  = "192.168.100.1"

 }
