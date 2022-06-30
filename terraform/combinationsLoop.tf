
locals {
  schemas    = [
                 "PRIVATE",
                 "PUBLIC",
                 "MY_SCHEMA",
               ]
  privileges = [
                 "CREATE TABLE",
                 "CREATE VIEW",
                 "USAGE",
               ]
  # Nested loop over both lists, and flatten the result.
  schema_privileges = distinct(flatten([
    for schema in local.schemas : [
      for privilege in local.privileges : {
        privilege = privilege
        schema    = schema
      }
    ]
  ]))
}

 resource "snowflake_schema_grant" "write_permissions" {
  # We need a map to use for_each, so we convert our list into a map by adding a unique key:
  for_each      = { for entry in local.schema_privileges: "${entry.schema}.${entry.privilege}" => entry }
  database_name = "MY_DATABASE"
  privilege     = each.value.privilege
  roles         = "DAVE"
  schema_name   = each.value.schema
}