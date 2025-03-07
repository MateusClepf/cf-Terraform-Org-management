resource "cloudflare_zone" "zone" {
  account_id  = var.cloudflare_account_tag
  paused      = false
  zone        = var.cloudflare_zone_name
  type        = var.cloudflare_zone_type
  plan        = var.cloudflare_zone_plan
}

resource "cloudflare_zone_settings_override" "zone-settings" {
  zone_id = cloudflare_zone.zone.id
  settings {
    always_use_https            = "on"
    browser_cache_ttl           = 0
    browser_check               = "on"
    http2                       = "on"
    h2_prioritization           = "off"
    http3                       = "off"
    image_resizing              = "on"
    ip_geolocation              = "on"
    ipv6                        = "on"
    mirage                      = "on"
    prefetch_preload            = "on"
    security_header {
      enabled            = false
    }
    ssl                         = "full"
    tls_1_3                     = "zrt"
    true_client_ip_header       = "on"
    websockets                  = "on"
    zero_rtt                    = "on"
    min_tls_version             = "1.2"
    polish            = "lossless"
    webp              = "on"
  }
}

resource "cloudflare_argo" "argo" {
  zone_id        = cloudflare_zone.zone.id
  smart_routing  = "on"
}

resource "cloudflare_tiered_cache" "tiered-cache" {
  zone_id    = cloudflare_zone.zone.id
  cache_type = "smart"
}

module "cloudflare_bot_management" {
  source = "github.com/MateusClepf/cf-Terraform-Org-management-modules/zone-modules/bot-management?ref=v1.0.0"
  
  zone_id = var.zone_id
}
/*
resource "cloudflare_bot_management" "bot-management" {
  zone_id                = cloudflare_zone.zone.id
  ai_bots_protection     = "disabled"
  auto_update_model      = true
  enable_js              = true
  suppress_session_score = false
}*/