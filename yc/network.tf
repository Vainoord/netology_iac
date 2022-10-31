# Network
resource "yandex_vpc_network" "default" {
  name = "netology_net"
}

resource "yandex_vpc_subnet" "default" {
  name = "netology_subnet"
  zone           = var.yandex_zone
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = ["192.168.101.0/24"]
}
