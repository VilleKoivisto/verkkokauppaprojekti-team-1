# Projekti 4/ ryhmä 1 / Terraformin muuttujat
# --------------------------------------------------

# Nämä haetaan terraform.tfvars-tiedostosta:
variable "project" {}

variable "credentials_file" {}

variable "sql_name" {}

variable "sql_password" {}

variable "deploy_db" {
  description = "Whether to deploy a Cloud SQL database or not."
  type        = bool
  default     = false
}

# Nämä määritellään tässä:
variable "region" {
  default = "europe-north1"
}

variable "zone" {
  default = "europe-north1-b"
}