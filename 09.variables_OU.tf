# =============================================
# Organizational Units Variables (prefix: ou_)
# =============================================

variable "ou_environment_names" {
  description = "List of environment names to create as Organizational Units under the root"
  type        = list(string)
  default     = ["DEV", "TEST", "PROD"]
}