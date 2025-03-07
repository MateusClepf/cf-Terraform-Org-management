# variables.tf
variable "zone_id" {
  description = "The Cloudflare Zone ID"
  type        = string
}

variable "ai_bots_protection" {
  description = "Whether to enable AI bots protection"
  type        = string
  default     = "disabled"
  validation {
    condition     = contains(["enabled", "disabled"], var.ai_bots_protection)
    error_message = "The ai_bots_protection value must be 'enabled' or 'disabled'"
  }
}

variable "auto_update_model" {
  description = "Whether to automatically update the model"
  type        = bool
  default     = true
}

variable "enable_js" {
  description = "Whether to enable JavaScript detection"
  type        = bool
  default     = true
}

variable "suppress_session_score" {
  description = "Whether to suppress session score"
  type        = bool
  default     = false
}