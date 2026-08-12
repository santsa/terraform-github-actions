# =============================================
# S3 Replication Variables (prefix: s3repl_)
# =============================================

variable "s3repl_iam_role_name" {
  description = "Name of the IAM role used for S3 replication"
  type        = string
  default     = "tf-iam-role-replication-santsa"
}

variable "s3repl_assume_role_service" {
  description = "AWS service principal allowed to assume the replication role"
  type        = string
  default     = "s3.amazonaws.com"
}

variable "s3repl_assume_role_action" {
  description = "STS action permitted in the assume role policy"
  type        = string
  default     = "sts:AssumeRole"
}

variable "s3repl_iam_policy_name" {
  description = "Name of the IAM policy granting S3 replication permissions"
  type        = string
  default     = "tf-iam-role-policy-replication-santsa"
}

variable "s3repl_source_bucket_actions" {
  description = "List of S3 actions allowed on the source bucket ARN"
  type        = list(string)
  default     = ["s3:ListBucket", "s3:GetReplicationConfiguration"]
}

variable "s3repl_source_object_actions" {
  description = "List of S3 actions allowed on source bucket objects"
  type        = list(string)
  default     = ["s3:GetObjectVersionForReplication", "s3:GetObjectVersionAcl"]
}

variable "s3repl_destination_actions" {
  description = "List of S3 actions allowed on destination bucket objects"
  type        = list(string)
  default     = [
    "s3:ReplicateObject",
    "s3:ReplicateDelete",
    "s3:ReplicateTags",
    "s3:GetObjectVersionTagging"
  ]
}

variable "s3repl_destination_bucket_name" {
  description = "Name of the destination S3 bucket for replication"
  type        = string
  default     = "tf-bucket-destination-santsa"
}

variable "s3repl_source_bucket_name" {
  description = "Name of the source S3 bucket with replication enabled"
  type        = string
  default     = "tf-bucket-source-santsa"
}

variable "s3repl_source_bucket_acl" {
  description = "ACL setting for the source S3 bucket"
  type        = string
  default     = "private"
}

variable "s3repl_versioning_enabled" {
  description = "Whether versioning is enabled on source and destination buckets"
  type        = bool
  default     = true
}

variable "s3repl_rule_id" {
  description = "Identifier for the S3 replication rule"
  type        = string
  default     = "foobar"
}

variable "s3repl_rule_prefix" {
  description = "Object key prefix filter for the replication rule"
  type        = string
  default     = "foo"
}

variable "s3repl_rule_status" {
  description = "Status of the replication rule (Enabled or Disabled)"
  type        = string
  default     = "Enabled"
}

variable "s3repl_destination_storage_class" {
  description = "Storage class for replicated objects in the destination bucket"
  type        = string
  default     = "STANDARD"
}