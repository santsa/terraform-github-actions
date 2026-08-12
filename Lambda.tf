## Zip the function to be run at function App.
data "archive_file" "init" {
  type        = var.lambda_archive_type
  source_file = "${path.module}/${var.lambda_source_file_path}"
  output_path = "${path.module}/${var.lambda_zip_output_name}"
}

## S3 Bucket
resource "aws_s3_bucket" "santsabucket" {
  bucket = var.lambda_s3_bucket_name

  tags = {
    Name = var.lambda_s3_bucket_tag_name
  }
}

## Upload zip file to s3 bucket (use aws_s3_object)
resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.santsabucket.id
  key    = var.lambda_s3_object_key
  source = data.archive_file.init.output_path
}

## IAM role for lambda
resource "aws_iam_role" "lambda_role" {
  name               = var.lambda_iam_role_name
  assume_role_policy = file(var.lambda_assume_role_policy_path)
}

## IAM role-policy for lambda
resource "aws_iam_role_policy" "lambda_policy" {
  name   = var.lambda_iam_policy_name
  role   = aws_iam_role.lambda_role.id
  policy = file(var.lambda_policy_path)
}

## AWS lambda functions
resource "aws_lambda_function" "test_lambda" {
  function_name = var.lambda_function_name
  s3_bucket     = aws_s3_bucket.santsabucket.id # Corregido: referencia al bucket creado arriba
  s3_key        = aws_s3_object.object.key      # Corregido: referencia al objeto subido
  role          = aws_iam_role.lambda_role.arn
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
}