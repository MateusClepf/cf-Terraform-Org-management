module "cloudflare_zone_settings_override" {
  source = "github.com/MateusClepf/cf-Terraform-Org-management-modules//zone-modules/zone-settings"
  
  zone_id = var.cloudflare_zone_id
}