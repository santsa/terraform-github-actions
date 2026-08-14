## AWS IAM ROLE
resource "aws_iam_role" "replication" {
  name = var.s3repl_iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = var.s3repl_assume_role_service }
        Action    = var.s3repl_assume_role_action
      }
    ]
  })
}

## AWS IAM Policy
resource "aws_iam_policy" "replication" {
  name = var.s3repl_iam_policy_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = var.s3repl_source_bucket_actions
        Effect   = "Allow"
        Resource = [aws_s3_bucket.source.arn]
      },
      {
        Action   = var.s3repl_source_object_actions
        Effect   = "Allow"
        Resource = ["${aws_s3_bucket.source.arn}/*"]
      },
      {
        Action   = var.s3repl_destination_actions
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.destination.arn}/*"
      }
    ]
  })
}

## AWS IAM policy and Role attachment
resource "aws_iam_role_policy_attachment" "replication" {
  role       = aws_iam_role.replication.name
  policy_arn = aws_iam_policy.replication.arn
}

## Replication Destination S3
resource "aws_s3_bucket" "destination" {
  bucket = var.s3repl_destination_bucket_name
}

resource "aws_s3_bucket_versioning" "destination" {
  bucket = aws_s3_bucket.destination.id

  versioning_configuration {
    status = var.s3repl_versioning_enabled ? "Enabled" : "Suspended"
  }
}

## AWS S3 for source
resource "aws_s3_bucket" "source" {
  provider = aws.central
  bucket   = var.s3repl_source_bucket_name
}

resource "aws_s3_bucket_acl" "source" {
  provider = aws.central
  bucket   = aws_s3_bucket.source.id
  acl      = var.s3repl_source_bucket_acl
}

resource "aws_s3_bucket_versioning" "source" {
  provider = aws.central
  bucket   = aws_s3_bucket.source.id

  versioning_configuration {
    status = var.s3repl_versioning_enabled ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_replication_configuration" "source" {
  provider = aws.central
  bucket   = aws_s3_bucket.source.id
  role     = aws_iam_role.replication.arn

  rule {
    id     = var.s3repl_rule_id
    prefix = var.s3repl_rule_prefix
    status = var.s3repl_rule_status

    destination {
      bucket        = aws_s3_bucket.destination.arn
      storage_class = var.s3repl_destination_storage_class
    }
  }

  depends_on = [aws_s3_bucket_versioning.source]
}