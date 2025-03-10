resource "cloudflare_account" "account" {
  name              = "1 - Mateus Lab Terraform"
  type              = "enterprise"
  enforce_twofactor = false
}
