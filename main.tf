# 1. Use the native Null Provider (built-in, requires no special repositories)
terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

# 2. Define a blank resource block that lets us trigger custom commands
resource "null_resource" "ubuntu_runbook_setup" {

  # Establish a secure connection directly to your local Ubuntu server
  connection {
    type        = "ssh"
    user        = var.ubuntu_user
    host        = var.var.ubuntu_ip
    private_key = file("~/.ssh/id_rsa")         # Points to your newly generated Mac SSH key
  }

  # Execute a shell command directly on the Ubuntu server
  provisioner "remote-exec" {
    inline = [
      "echo 'Runbook: This server is managed via native Terraform and tracked on GitHub!' > ~/terraform_runbook.txt",
      "cat ~/terraform_runbook.txt"
    ]
  }
}
