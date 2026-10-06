## SNS topic
resource "aws_sns_topic" "awssnstopic" {
  name = var.sns_topic_name
}

## SQS DLQ
resource "aws_sqs_queue" "santsa_dl_queue" {
  name = var.sqs_dlq_name
}

## SQS Primary
resource "aws_sqs_queue" "santsa_queue" {
  name                      = var.sqs_queue_name
  visibility_timeout_seconds = var.sqs_visibility_timeout_seconds

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.santsa_dl_queue.arn
    maxReceiveCount     = 5
  })

  tags = {
    Environment = var.environment
  }
}

## SNS topic subscription
resource "aws_sns_topic_subscription" "santsa_updates_sqs_target" {
  topic_arn = aws_sns_topic.awssnstopic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.santsa_queue.arn
}

## SQS Policy to allow SNS to send messages
resource "aws_sqs_queue_policy" "santsa_queue_policy" {
  queue_url = aws_sqs_queue.santsa_queue.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "sns.amazonaws.com" }
        Action    = "sqs:SendMessage"
        Resource  = aws_sqs_queue.santsa_queue.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.awssnstopic.arn
          }
        }
      }
    ]
  })
}

# AWS IAM Role SQS Policy
resource "aws_iam_role_policy" "lambda_role_sqs_policy" {
  name = var.policy_name
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:ChangeMessageVisibility",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:ReceiveMessage"
        ]
        Resource = aws_sqs_queue.santsa_queue.arn
      }
    ]
  })
}

# AWS IAM Role Logs Policy
resource "aws_iam_role_policy" "lambda_role_logs_policy" {
  name = "LambdaRolePolicy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

## Event Source mapping
resource "aws_lambda_event_source_mapping" "queue_event_source_lambda" {
  event_source_arn = aws_sqs_queue.santsa_queue.arn
  function_name    = aws_lambda_function.test_lambda.arn
}