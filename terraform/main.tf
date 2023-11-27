terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token                    = "y0_AgAAAAAJ89LzAATuwQAAAADXw9Jg9c02CFcWRByVNmiLPNOJSPw0xPA"
  cloud_id                 = "b1gc7onttnadnivcrdpf"
  folder_id                = "b1g43aq7nnnac7rsogvm"
  zone                     = "ru-central1-a"
}

resource "yandex_compute_instance" "vm-1" {
  name = "terraform1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd87kbts7j40q5b9rpjr"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
  }

  network_interface {
    nat       = true
    nat_ip_address = yandex_vpc_address.external-ipaddress.external_ipv4_address
  }
  
  metadata = {
    ssh-keys = "ubuntu:${file("./id_rsa.pub")}"
  }

}

resource "yandex_vpc_address" "external-ipaddress" {
  name = "external-ipaddress"

  external_ipv4_address {
    zone_id = "ru-central1-a"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network-1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet-1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.terraform1.network_interface.0.ip_address
}
output "external_ip_address_vm_1" {
  value = yandex_compute_instance.terraform1.network_interface.1.nat_ip_address
}

