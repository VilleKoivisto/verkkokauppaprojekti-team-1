# Alustetaan Terraform
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.3.0"
    }
  }
}

provider "google" {
  #credentials = file(var.credentials_file)
  project = var.project
  region  = var.region
  zone    = var.zone
}

provider "google-beta" {
  #credentials = file(var.credentials_file)
  project = var.project
  region  = var.region
  zone    = var.zone
}

# Google Cloud Source Repository
resource "google_sourcerepo_repository" "repo" {
  name = var.repository_name
}

### Luodaan ämpäri, zipit ja funktiot
# Access control bucketille
resource "google_storage_bucket_access_control" "public_rule" {
  bucket = google_storage_bucket.bucket.name
  role   = "OWNER"
  entity = "allUsers"
}

# Ämpäri jossa koodit funktioille
resource "google_storage_bucket" "bucket" {
  provider = google
  name     = "sisaelin-bucketti"
  location = "US"
}

# Zipattu koodi #1 ämpäriin
resource "google_storage_bucket_object" "zip-1" {
  provider  = google
  name      = "hae-kaikki-tuotteet"
  bucket    = google_storage_bucket.bucket.name
  source    = "../functions/hae-kaikki-tuotteet.zip"
}

# Luo funktio zipissä olevasta koodi #1 stä
resource "google_cloudfunctions_function" "func-1" {
  provider    = google
  name        = "hae-kaikki-tuotteet"
  description = "Hakee kaikki tuotteet tietokannasta"
  runtime     = "python39"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.zip-1.name
  trigger_http          = true
  entry_point           = "get_all_items"
}

# tää pitää olla jotta on julkisesti saatavilla
resource "google_cloudfunctions_function_iam_member" "invoker" {
  provider       = google
  cloud_function = google_cloudfunctions_function.func-1.name
  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

# Zipattu koodi #2 ämpäriin
resource "google_storage_bucket_object" "zip-2" {
  provider  = google
  name      = "lisaa-tuote"
  bucket    = google_storage_bucket.bucket.name
  source    = "../functions/lisaa-tuote.zip"
}

# Luo funktio zipissä olevasta koodi #2 stä
resource "google_cloudfunctions_function" "func-2" {
  provider    = google
  name        = "lisaa-tuote"
  description = "Hakee kaikki tuotteet tietokannasta"
  runtime     = "python39"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.zip-2.name
  trigger_http          = true
  entry_point           = "insert_to_cart"
}

# tää pitää olla jotta on julkisesti saatavilla
resource "google_cloudfunctions_function_iam_member" "invoker" {
  provider       = google
  cloud_function = google_cloudfunctions_function.func-2.name
  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

# Zipattu koodi #3 ämpäriin
resource "google_storage_bucket_object" "zip-3" {
  provider  = google
  name      = "hae-kaikki-tuotteet"
  bucket    = google_storage_bucket.bucket.name
  source    = "../functions/ostoskori.zip"
}

# Luo funktio zipissä olevasta koodi #3 stä
resource "google_cloudfunctions_function" "func-3" {
  provider    = google
  name        = "ostoskori"
  description = "Hakee kaikki tuotteet tietokannasta"
  runtime     = "python39"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.zip-3.name
  trigger_http          = true
  entry_point           = "get_cart"
}

# tää pitää olla jotta on julkisesti saatavilla
resource "google_cloudfunctions_function_iam_member" "invoker" {
  provider       = google
  cloud_function = google_cloudfunctions_function.func-3.name
  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

# Zipattu koodi #4 ämpäriin
resource "google_storage_bucket_object" "zip-4" {
  provider  = google
  name      = "hae-yksi-elin"
  bucket    = google_storage_bucket.bucket.name
  source    = "../functions/hae-yksi-elin.zip"
}

# Luo funktio zipissä olevasta koodi #4 stä
resource "google_cloudfunctions_function" "func-4" {
  provider    = google
  name        = "hae-yksi-elin"
  description = "Hakee kaikki tuotteet tietokannasta"
  runtime     = "python39"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.zip-4.name
  trigger_http          = true
  entry_point           = "get_single_item"
}

# tää pitää olla jotta on julkisesti saatavilla
resource "google_cloudfunctions_function_iam_member" "invoker" {
  provider       = google
  cloud_function = google_cloudfunctions_function.func-4.name
  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}


### Luodaan API, gateway ja config

# Luodaan API 
resource "google_api_gateway_api" "hannibal_api" {
  provider = google-beta
  api_id = "hannibal-api"
}

# Luodaan config
resource "google_api_gateway_api_config" "hannibal_config" {
  provider = google-beta
  api = google_api_gateway_api.hannibal_api.api_id
  api_config_id = "hannibal-config"

  openapi_documents {
    document {
      path = "spec.yaml"
      contents = filebase64("../api-gateway/api-config.yaml")
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

# Luodaan gateway
resource "google_api_gateway_gateway" "hannibal_gateway" {
  provider = google-beta
  api_config = google_api_gateway_api_config.hannibal_config.api_config_id
  gateway_id = "hannibal-gateway"
}