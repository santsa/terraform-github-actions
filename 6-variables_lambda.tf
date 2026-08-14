variable "lambda_archive_type" {
  description = "Compression type for the deployment archive file"
  type        = string
  default     = "zip"
}

variable "lambda_source_file_path" {
  description = "Relative path to the Lambda function source file"
  type        = string
  default     = "Project/Lambda/hello.js"
}

variable "lambda_zip_output_name" {
  description = "Output filename for the generated zip archive"
  type        = string
  default     = "Project/Lambda/hello.zip"
}

variable "lambda_s3_bucket_name" {
  description = "Unique name of the S3 bucket used to store the artifact"
  type        = string
  default     = "quicksantsabucket001"
}

variable "lambda_s3_bucket_tag_name" {
  description = "Value of the Name tag for the S3 bucket"
  type        = string
  default     = "santsabucket-1"
}

variable "lambda_s3_object_key" {
  description = "Key (path) of the zip object within the S3 bucket"
  type        = string
  default     = "hello.zip"
}

variable "lambda_iam_role_name" {
  description = "Name of the IAM role associated with the Lambda function"
  type        = string
  default     = "lambda_role"
}

variable "lambda_assume_role_policy_path" {
  description = "File path to the IAM assume role policy JSON document"
  type        = string
  default     = "Project/Lambda/lambda_assume_role_policy.json"
}

variable "lambda_iam_policy_name" {
  description = "Name of the inline IAM role policy"
  type        = string
  default     = "lambda_policy"
}

variable "lambda_policy_path" {
  description = "File path to the Lambda permissions policy JSON document"
  type        = string
  default     = "Project/Lambda/lambda_policy.json"
}

variable "lambda_function_name" {
  description = "Name of the AWS Lambda function"
  type        = string
  default     = "hello"
}

variable "lambda_handler" {
  description = "Entry point for the Lambda function (file.method)"
  type        = string
  default     = "hello.handler"
}

variable "lambda_runtime" {
  description = "Execution runtime identifier for the Lambda function"
  type        = string
  default     = "nodejs22.x"
}