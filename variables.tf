variable "azure_subscription_id" {
  type        = string
  description = "My subscription id"
  default     = ""
  sensitive   = true
}



variable "backend_repo" {
  type        = string
  description = "Github repo link"
  default     = "https://github.com/mo-ayman/laravel"
}


variable "DOCKER_USER_NAME" {
  type    = string
  default = ""
}

variable "DOCKER_PASSWORD" {
  type    = string
  default = ""
}

variable "DB_USER_NAME" {
  type    = string
  default = ""
}

variable "DB_PASSWORD" {
  type    = string
  default = ""
}