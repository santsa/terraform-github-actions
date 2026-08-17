# =============================================
# SCP / Organizations Variables (prefix: scp_)
# =============================================

variable "scp_ou_name" {
  description = "Name of the Organizational Unit for SCP enforcement"
  type        = string
  default     = "SCPDemoOU"
}

variable "scp_policy_name" {
  description = "Name of the Service Control Policy"
  type        = string
  default     = "aws_ou_scp"
}

variable "scp_policy_description" {
  description = "Description of what the SCP enforces"
  type        = string
  default     = "Deny EC2 instance launches that are not t2.micro"
}

variable "scp_statement_sid" {
  description = "Statement ID within the SCP JSON document"
  type        = string
  default     = "RequireMicroInstanceType"
}

variable "scp_allowed_instance_type" {
  description = "The only EC2 instance type permitted by the SCP"
  type        = string
  default     = "t3.micro"
}