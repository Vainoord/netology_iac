# Put your yandex cloud token here
variable "yandex_token" {
  default = ""
}

# Put your yandex cloud id here
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_cloud_id" {
  default = ""
}

# Put your yandex cloud folder id here
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_folder_id" {
  default = ""
}

# Put your image id for your yandex cloud instance
# ID можно узнать с помощью команды yc compute image list
variable "centos-7-base" {
  default = "fd88d14a6790do254kj7"
}

# Put your image id for your yandex cloud instance
variable "ubuntu-2204" {
  default = "fd8egv6phshj1f64q94n"
}

# Put your yandex cloud zone here
variable "yandex_zone" {
  default = "ru-central1-a"
}
