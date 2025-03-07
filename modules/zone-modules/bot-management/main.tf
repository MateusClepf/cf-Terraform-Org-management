# main.tf
resource "cloudflare_bot_management" "this" {
  zone_id                = var.zone_id
  ai_bots_protection     = var.ai_bots_protection
  auto_update_model      = var.auto_update_model
  enable_js              = var.enable_js
  suppress_session_score = var.suppress_session_score
}