terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

resource "null_resource" "ubuntu_runbook_setup" {

  connection {
    type        = "ssh"
    user        = var.ubuntu_user
    host        = var.ubuntu_ip          
    private_key = file("~/.ssh/id_rsa")
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p ~/runbooks",
      "cat << 'EOF' > ~/runbooks/system_health_report.txt",
      "==================================================",
      "         AUTOMATED SYSTEM HEALTH REPORT           ",
      "==================================================",
      "Generated on: $(date)",
      "echo ''",
      "--- 1. SYSTEM UPTIME & LOAD ---",
      "$(uptime)",
      "echo ''",
      "--- 2. MEMORY USAGE (MB) ---",
      "$(free -m)",
      "echo ''",
      "--- 3. HARD DRIVE DISK SPACE ---",
      "$(df -h /)",
      "==================================================",
      "EOF",
      "cat ~/runbooks/system_health_report.txt" 
    ]
  }
}
