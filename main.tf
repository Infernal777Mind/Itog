terraform {
  required_providers {
    yandex = {
      source = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}
provider "yandex" {
  token     = "token"
  cloud_id  = "cloud"
  folder_id = "folder"
  zone      = "ru-central1-a"
}
resource "yandex_compute_instance" "vm-1" {
  name = "node-1"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8hguc7o9hhr5bcvhql"
      size     = 40
    }
  }

  network_interface {
    subnet_id  = "e9bpen7ln9abjbcsud2l"
    nat        = true
    ip_address = "10.128.0.10"
  }

  metadata = {
    user-data = "${file("/home/infernal/ITOG/Itog/meta.txt")}"
  }

  provisioner "local-exec" {
    command = "sed -i 's/host1/'${yandex_compute_instance.vm-1.network_interface.0.nat_ip_address}'/' ./hosts-kafka"
  }
}
resource "yandex_compute_instance" "vm-2" {
  name = "node-2"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8hguc7o9hhr5bcvhql"
      size     = 40
    }
  }

  network_interface {
    subnet_id  = "e9bpen7ln9abjbcsud2l"
    nat        = true
    ip_address = "10.128.0.11"
  }

  metadata = {
    user-data = "${file("/home/infernal/ITOG/Itog/meta.txt")}"
  }

  provisioner "local-exec" {
    command = "sed -i 's/host2/'${yandex_compute_instance.vm-2.network_interface.0.nat_ip_address}'/' ./hosts-kafka"
  }
}
resource "yandex_compute_instance" "vm-3" {
  name = "node-3"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8hguc7o9hhr5bcvhql"
      size     = 40
    }
  }

  network_interface {
    subnet_id  = "e9bpen7ln9abjbcsud2l"
    nat        = true
    ip_address = "10.128.0.12"
  }

  metadata = {
    user-data = "${file("/home/infernal/ITOG/Itog/meta.txt")}"
  }

  provisioner "local-exec" {
    command = "sed -i 's/host3/'${yandex_compute_instance.vm-3.network_interface.0.nat_ip_address}'/' ./hosts-kafka"
  }
}
