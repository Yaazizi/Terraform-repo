## Terraform setup für iCS-VM mit ssh-config ##
## sollte man zuerst mit VPN verbunden sein ##


terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.53.0"
    }
  }
}

provider "openstack" {
  cloud    = "openstack"
  username = var.openstack_username
  password = var.openstack_password
}

resource "openstack_compute_instance_v2" "mustername" {
  name        = "mustername"
  flavor_name = "flavor_name"
  image_name  = "dein_image_name"
  image_id    = "dein_image_id"
  
  security_groups = ["default"]

  network {
    name = "dein_netzwerk_name"
  }

  user_data = <<-EOF
    #cloud-config

    users:
      - name: "mustername"
        ssh_authorized_keys:
          - file:///path/to/your/public/key.pub
  EOF
}

## Intallatintion von Terrafrom je nachdem der Betribsystem  

## nach der Anpassung das Code und in clouds.yaml mit der rechtige Werte 

## führe in dein Terminal terraform init  

## und terraform apply aus 