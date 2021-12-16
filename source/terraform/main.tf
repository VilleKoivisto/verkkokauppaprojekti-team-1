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
resource "google_storage_bucket_object" "zip_1" {
  provider  = google
  name      = "get_all_items"
  bucket    = google_storage_bucket.bucket.name
  source    = "../functions/get_all_items.zip"
}

# Luo funktio zipissä olevasta koodi #1 stä
resource "google_cloudfunctions_function" "func_1" {
  provider    = google
  name        = "get_all_items"
  description = "Hakee kaikki tuotteet tietokannasta"
  runtime     = "python39"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.zip_1.name
  trigger_http          = true
  entry_point           = "get_all_items"
}

# Zipattu koodi #2 ämpäriin
resource "google_storage_bucket_object" "zip_2" {
  provider  = google
  name      = "insert_to_cart"
  bucket    = google_storage_bucket.bucket.name
  source    = "../functions/push_to_cart.zip"
}

# Luo funktio zipissä olevasta koodi #2 stä
resource "google_cloudfunctions_function" "func_2" {
  provider    = google
  name        = "insert_to_cart"
  description = "Hakee kaikki tuotteet tietokannasta"
  runtime     = "python39"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.zip_2.name
  trigger_http          = true
  entry_point           = "insert_to_cart"
}

# Zipattu koodi #3 ämpäriin
resource "google_storage_bucket_object" "zip_3" {
  provider  = google
  name      = "get_cart"
  bucket    = google_storage_bucket.bucket.name
  source    = "../functions/get_cart.zip"
}

# Luo funktio zipissä olevasta koodi #3 stä
resource "google_cloudfunctions_function" "func_3" {
  provider    = google
  name        = "get_cart"
  description = "Hakee kaikki tuotteet tietokannasta"
  runtime     = "python39"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.zip_3.name
  trigger_http          = true
  entry_point           = "get_cart"
}

# Zipattu koodi #4 ämpäriin
resource "google_storage_bucket_object" "zip_4" {
  provider  = google
  name      = "get_single_item"
  bucket    = google_storage_bucket.bucket.name
  source    = "../functions/get_one_item.zip"
}

# Luo funktio zipissä olevasta koodi #4 stä
resource "google_cloudfunctions_function" "func_4" {
  provider    = google
  name        = "get_single_item"
  description = "Hakee kaikki tuotteet tietokannasta"
  runtime     = "python39"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.zip_4.name
  trigger_http          = true
  entry_point           = "get_single_item"
}

# tää pitää olla jotta on julkisesti saatavilla
resource "google_cloudfunctions_function_iam_member" "invoker_1" {
  provider       = google
  cloud_function = google_cloudfunctions_function.func_1.name
  role   = "roles/cloudfunctions.invoke"
  member = "allUsers"
}

resource "google_cloudfunctions_function_iam_member" "invoker_2" {
  provider       = google
  cloud_function = google_cloudfunctions_function.func_2.name
  role   = "roles/cloudfunctions.invoke"
  member = "allUsers"
}

resource "google_cloudfunctions_function_iam_member" "invoker_3" {
  provider       = google
  cloud_function = google_cloudfunctions_function.func_3.name
  role   = "roles/cloudfunctions.invoke"
  member = "allUsers"
}

resource "google_cloudfunctions_function_iam_member" "invoker_4" {
  provider       = google
  cloud_function = google_cloudfunctions_function.func_4.name
  role   = "roles/cloudfunctions.invoke"
  member = "allUsers"
}


### Luodaan API, gateway ja config

# Luodaan API 
resource "google_api_gateway_api" "hannibal_gw" {
  provider = google-beta
  api_id = "hannibal-gw"
}

# Luodaan config
resource "google_api_gateway_api_config" "hannibal_gw" {
  provider = google-beta
  api = google_api_gateway_api.hannibal_gw.api_id
  api_config_id = "config"

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
resource "google_api_gateway_gateway" "hannibal_gw" {
  provider = google-beta
  api_config = google_api_gateway_api_config.hannibal_gw.id
  gateway_id = "hannibal-gw"
}