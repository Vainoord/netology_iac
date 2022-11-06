# Домашнее задание к занятию "7.3. Основы и принцип работы Терраформ"

## Задача 1. Создадим бэкэнд в S3 (необязательно, но крайне желательно).

Если в рамках предыдущего задания у вас уже есть аккаунт AWS, то давайте продолжим знакомство со взаимодействием
терраформа и aws. 

1. Создайте s3 бакет, iam роль и пользователя от которого будет работать терраформ. Можно создать отдельного пользователя,
а можно использовать созданного в рамках предыдущего задания, просто добавьте ему необходимы права, как описано 
[здесь](https://www.terraform.io/docs/backends/types/s3.html).
1. Зарегистрируйте бэкэнд в терраформ проекте как описано по ссылке выше. 

#### Ответ

Сразу определим два `workspace` - `stage` и `prod`. \
```
13:54:28 | ~/netology/netology_iac/aws [main]$> terraform workspace new stage
Created and switched to workspace "stage"!

You're now on a new, empty workspace. Workspaces isolate their state,
so if you run "terraform plan" Terraform will not see any existing state
for this configuration.
13:54:36 | ~/netology/netology_iac/aws [main]$> terraform workspace new prod
Created and switched to workspace "prod"!

You're now on a new, empty workspace. Workspaces isolate their state,
so if you run "terraform plan" Terraform will not see any existing state
for this configuration.
```
Добавим блок backend без таблицы `dynamodb`, т.к. для этого требуется существующая таблица dynamodb в aws. Использование backend'a в блоке `terraform`:
```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  ###
  # Using the s3 backend
  ###
  backend "s3" {
    bucket = "vainoord-s3-bucket"
    encrypt = true
    key = "netology/terraform.tfstate"
    region = "eu-central-1"
  }
}
```
Пользователю в AWS добавлена группа `AmazonS3FullAccess`.

## Задача 2. Инициализируем проект и создаем воркспейсы. 

1. Выполните `terraform init`:
    * если был создан бэкэнд в S3, то терраформ создат файл стейтов в S3 и запись в таблице 
dynamodb.
    * иначе будет создан локальный файл со стейтами.  
1. Создайте два воркспейса `stage` и `prod`.
1. В уже созданный `aws_instance` добавьте зависимость типа инстанса от вокспейса, что бы в разных ворскспейсах 
использовались разные `instance_type`.
1. Добавим `count`. Для `stage` должен создаться один экземпляр `ec2`, а для `prod` два. 
1. Создайте рядом еще один `aws_instance`, но теперь определите их количество при помощи `for_each`, а не `count`.
1. Что бы при изменении типа инстанса не возникло ситуации, когда не будет ни одного инстанса добавьте параметр
жизненного цикла `create_before_destroy = true` в один из рессурсов `aws_instance`.
1. При желании поэкспериментируйте с другими параметрами и рессурсами.

В виде результата работы пришлите:
* Вывод команды `terraform workspace list`.
* Вывод команды `terraform plan` для воркспейса `prod`.  


#### Ответ

Мой список `workspaces`:
```
13:05:50 | ~/netology/netology_iac/aws [main]$> terraform workspace list
  default
* prod
  stage

```
Вывод `terraform plan` для воркспейса `prod` ниже. Я сократил размеры блоков, т.к. большая часть параметров ресурсов будет определена по умолчанию в процессе их создания:
```
Terraform will perform the following actions:

# aws_instance.aws_ec2_tf_v1[0] will be created
  + resource "aws_instance" "aws_ec2_tf_v1" {
      + ami                                  = "ami-0965bd5ba4d59211c"
      + instance_type                        = "t2.micro"
      + subnet_id                            = "subnet-06add6ac27ee4cf6c"
      + tags                                 = {
          + "Name" = "Ubuntu_ec2"
        }
      + tags_all                             = {
          + "Name" = "Ubuntu_ec2"
        }
      + vpc_security_group_ids               = [
            + "sg-072e19e231db8d9e8",
          ]

      **********************
    }

# aws_instance.aws_ec2_tf_v1[1] will be created
  + resource "aws_instance" "aws_ec2_tf_v1" {
      + ami                                  = "ami-0965bd5ba4d59211c"
      + instance_type                        = "t2.micro"
      + subnet_id                            = "subnet-06add6ac27ee4cf6c"
      + tags                                 = {
          + "Name" = "Ubuntu_ec2"
        }
      + tags_all                             = {
          + "Name" = "Ubuntu_ec2"
        }
      + vpc_security_group_ids               = [
            + "sg-072e19e231db8d9e8",
          ]

      **********************
    }

# aws_instance.aws_ec2_tf_v2["t2.micro"] will be created
  + resource "aws_instance" "aws_ec2_tf_v2" {
      + ami                                  = "ami-070b208e993b59cea"
      + instance_type                        = "t2.micro"
      + subnet_id                            = "subnet-06add6ac27ee4cf6c"
      + tags                                 = {
          + "Name" = "Amazon_ec2"
        }
      + tags_all                             = {
          + "Name" = "Amazon_ec2"
        }
      + vpc_security_group_ids               = [
            + "sg-072e19e231db8d9e8",
          ]

      **********************
    }

# aws_instance.aws_ec2_tf_v2["t3.micro"] will be created
  + resource "aws_instance" "aws_ec2_tf_v2" {
      + ami                                  = "ami-0965bd5ba4d59211c"
      + instance_type                        = "t3.micro"
      + subnet_id                            = "subnet-06add6ac27ee4cf6c"
      + tags                                 = {
          + "Name" = "Amazon_ec2"
        }
      + tags_all                             = {
          + "Name" = "Amazon_ec2"
        }
      + vpc_security_group_ids               = [
            + "sg-072e19e231db8d9e8",
          ]

      **********************
    }

# aws_network_interface.aws_ec2_iface will be created
  + resource "aws_network_interface" "aws_ec2_iface" {
      + id                        = (known after apply)
      + subnet_id                 = "subnet-06add6ac27ee4cf6c"
      + tags                      = {
          + "Name" = "primary_network_interface"
        }
      + tags_all                  = {
          + "Name" = "primary_network_interface"
        }
      
      **********************
    }

# aws_security_group.tf_servers will be created
  + resource "aws_security_group" "tf_servers" {
      + arn                    = (known after apply)
      + description            = "Dynamic Security Group"
      + egress                 = [
          + { ******
            },
        ]
      + ingress                = [
          + { ******
            },
        ]
    }

# aws_subnet.test_subnet will be created
  + resource "aws_subnet" "test_subnet" {
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "eu-central-1a"
      + cidr_block                                     = "192.168.110.0/26"
      + tags                                           = {
          + "Name" = "subnet_example"
        }
      + tags_all                                       = {
          + "Name" = "subnet_example"
        }
      + vpc_id                                         = (known after apply)

      **********************
    }

# aws_vpc.test_network will be created
  + resource "aws_vpc" "test_network" {
      + arn                                  = (known after apply)
      + cidr_block                           = "192.168.110.0/24"
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + tags                                 = {
          + "Name" = "network_example"
        }
      + tags_all                             = {
          + "Name" = "network_example"
        }
      
      **********************
    }


Plan: 8 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + IPv4_ec2_instance  = [
      + (known after apply),
    ]
  + IPv4_ec2_subnet_id = [
      + (known after apply),
    ]
  + current_region     = "eu-central-1"
```
---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---