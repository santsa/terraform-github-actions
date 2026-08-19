## OU Units (created dynamically via for_each)
resource "aws_organizations_organizational_unit" "environments" {
  for_each  = toset(var.ou_environment_names)
  name      = each.value
  parent_id = data.aws_organizations_organization.org.roots[0].id
}