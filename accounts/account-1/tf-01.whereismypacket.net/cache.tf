resource "cloudflare_tiered_cache" "tiered-cache" {
  zone_id    = var.cloudflare_zone_id
  cache_type = "smart"
}