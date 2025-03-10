module "cloudflare_bot_management" {
  source = "github.com/MateusClepf/cf-Terraform-Org-management-modules//zone-modules/bot-management"
  
  zone_id = var.cloudflare_zone_id
}
