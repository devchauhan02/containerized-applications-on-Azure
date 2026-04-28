locals {
  normalized_label_prefix = trim(replace(lower(var.name_prefix), "/[^0-9a-z-]/", "-"), "-")
  normalized_alnum_prefix = replace(lower(var.name_prefix), "/[^0-9a-z]/", "")

  rg_name       = format("%s-rg", substr(local.normalized_label_prefix, 0, 50))
  aci_name      = format("%s-ci", substr(local.normalized_label_prefix, 0, 50))
  acr_name      = format("%scr", substr(local.normalized_alnum_prefix, 0, 45))
  aks_name      = format("%s-aks", substr(local.normalized_label_prefix, 0, 50))
  keyvault_name = format("%s-kv", substr(local.normalized_label_prefix, 0, 20))
  redis_name    = format("%s-redis", substr(local.normalized_label_prefix, 0, 50))

  aci_dns_name_label = substr(local.aci_name, 0, 63)
  common_tags = {
    Creator = var.student_email
  }
}