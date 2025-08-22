# Define o provedor da AWS
provider "aws" {
  region = "us-east-1"
}

# 1. Lê o arquivo YAML e decodifica-o para uma variável local do Terraform
locals {
  app_config = yamldecode(file("${path.root}/values.yaml"))
}

# 2. Chama o módulo, passando o objeto de configuração completo
module "my_ec2" {
  source = "../../modules/ec2" # Caminho para o módulo local
  config = local.app_config # Passa o conteúdo do YAML como uma única variável
}