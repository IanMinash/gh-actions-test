variable "registry" {
  description = "Registry to pull the image from"
  type        = string
}

variable "registry_username" {
  description = "Username to use against the registry."
  type        = string
}

variable "registry_password" {
  description = "Password to use against the registry."
  type        = string
  sensitive   = true
}

variable "registry_email" {
  description = "Email to use against the registry."
  type        = string
  nullable    = true
}

variable "image_url" {
  description = "Image of the Flask app"
  type        = string
}

variable "az_subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}
