variable "project" {
  default = "	week-10-fall-1"
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-c"
}
variable "repository_name" {
  description = "Name of the Google Cloud Source Repository to create."
  type        = string
  default     = "hannibal-repo"
}

#variable "credentials_file" {
#  default = "./.json"
#}