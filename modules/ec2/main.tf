# Cria o grupo de segurança (firewall)
resource "aws_security_group" "app_sg" {
  name = "${var.config.app_name}-sg"

  # Itera sobre a lista de regras de firewall vinda do YAML
  dynamic "ingress" {
    for_each = var.config.firewall_rules
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  tags = {
    Name        = "${var.config.app_name}-sg"
    Environment = var.config.environment
  }
}

# Cria a instância EC2
resource "aws_instance" "app_server" {
  ami           = var.config.instance.ami
  instance_type = var.config.instance.type
  security_groups = [aws_security_group.app_sg.name]

  tags = {
    Name        = var.config.app_name
    Environment = var.config.environment
  }
}