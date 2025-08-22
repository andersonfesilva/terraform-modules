# O módulo espera receber um único objeto chamado 'config'.
# Podemos adicionar validações para garantir que a estrutura está correta.
variable "config" {
  type = object({
    app_name    = string
    environment = string
    instance = object({
      type = string
      ami  = string
    })
    firewall_rules = list(object({
      name        = string
      port        = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  })
  description = "Objeto de configuração completo lido do arquivo YAML."

  validation {
    condition     = can(var.config.app_name) && can(var.config.environment) && can(var.config.instance) && can(var.config.firewall_rules)
    error_message = "A configuração deve conter 'app_name', 'environment', 'instance' e 'firewall_rules'."
  }
}