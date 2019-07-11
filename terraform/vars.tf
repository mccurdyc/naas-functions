variable "base_url" {
  type        = string
  description = "The API base url."
}

variable "function_timeout" {
  type        = number
  description = "The timeout (in seconds) of a function."
}

variable "region" {
  type        = string
  description = "The region where the function should be created."
}

variable "runtime" {
  type = string
  description = "The runtime of the Cloud Function (e.g., nodejs6, nodejs8, nodejs10, go111 or python37)"
}
