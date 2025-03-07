variable "cloudflare_account_tag" {
  type    = string
  default = "04603eafd30d96a4260074724bba2e43"
}

variable "cloudflare_zone_name" {
  type    = string
  default = "tf-01.whereismypacket.net"
}

variable "cloudflare_zone_plan" {
  type    = string
  default = "enterprise"
}

variable "cloudflare_zone_type" {
  type    = string
  default = "full"
}
variable "apiKey" {
  type    = string
  sensitive = true
}