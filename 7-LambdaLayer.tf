## create a zip file for the Lambda layer
data "archive_file" "lambda_layer_zip" {
  type        = var.lambda_layer_archive_type
  source_dir  = "${path.module}/${var.lambda_layer_source_dir}"
  output_path = "${path.module}/${var.lambda_layer_output_zip}"
}

resource "aws_lambda_layer_version" "lambda_layer_creation" {
  filename            = data.archive_file.lambda_layer_zip.output_path
  layer_name          = var.lambda_layer_name
  compatible_runtimes = var.lambda_layer_compatible_runtimes
  description         = var.lambda_layer_description
}
