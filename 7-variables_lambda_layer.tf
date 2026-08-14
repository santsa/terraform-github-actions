variable "lambda_layer_archive_type" {
  description = "Compression format for the Lambda layer archive"
  type        = string
  default     = "zip"
}

variable "lambda_layer_source_dir" {
  description = "Relative path to the directory containing the python/ folder for the layer"
  type        = string
  default     = "Project/LambdaLayer"
}

variable "lambda_layer_output_zip" {
  description = "Output path for the generated layer zip file"
  type        = string
  default     = "Project/LambdaLayer/hello_layer.zip"
}

variable "lambda_layer_name" {
  description = "Name of the Lambda layer version"
  type        = string
  default     = "hello-world-layer"
}

variable "lambda_layer_compatible_runtimes" {
  description = "List of compatible runtimes for the Lambda layer"
  type        = list(string)
  default     = ["python3.9", "python3.10", "python3.11", "python3.12"]
}

variable "lambda_layer_description" {
  description = "Description of the Lambda layer purpose"
  type        = string
  default     = "Layer with hello_world utility function"
}