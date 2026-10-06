variable "sns_topic_name" {
  type        = string
  description = "Nombre del tema SNS"
  default = "santsa-topic"
}

variable "sqs_queue_name" {
  type        = string
  description = "Nombre de la cola SQS principal"
  default = "santsa-updates-queue"
}

variable "sqs_visibility_timeout_seconds" {
  type        = number
  description = "Tiempo de espera de visibilidad para la cola SQS"
  default     = 300
}

variable "environment" {
  type        = string
  description = "Entorno de despliegue"
  default = "dev"
}

variable "sqs_dlq_name" {
  type        = string
  description = "Nombre de la cola SQS Dead Letter Queue (DLQ)"
  default = "santsa-updates-dl-queue"
}

variable "policy_name" {
  type        = string
  description = "Nombre de la política IAM de SQS"
  default = "AllowSQSPermissions"
}