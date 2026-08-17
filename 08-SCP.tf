## Get root data
data "aws_organizations_organization" "org" {}

## OU Unit
resource "aws_organizations_organizational_unit" "scp_demo_ou" {
  name      = var.scp_ou_name
  parent_id = data.aws_organizations_organization.org.roots[0].id
}

## Create SCP - to restrict instance types
resource "aws_organizations_policy" "aws_ou_scp" {
  name        = var.scp_policy_name
  description = var.scp_policy_description
  type        = "SERVICE_CONTROL_POLICY"
  content     = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = var.scp_statement_sid
        Effect   = "Deny"
        Action   = "ec2:RunInstances"
        Resource = "*"
        Condition = {
          StringNotEquals = {
            "ec2:InstanceType" = var.scp_allowed_instance_type
          }
        }
      }
    ]
  })
}

## Attaching policy to OU
resource "aws_organizations_policy_attachment" "aws_ou_scp" {
  policy_id = aws_organizations_policy.aws_ou_scp.id
  target_id = aws_organizations_organizational_unit.scp_demo_ou.id
}