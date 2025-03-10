module "cloudflare_ruleset" {
  #waf zone level managed rules module
  source = "github.com/MateusClepf/cf-Terraform-Org-management-modules//zone-modules/waf-managed-rules"
  
  zone_id = var.cloudflare_zone_id
}
