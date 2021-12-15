# Terraformin alustus
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
  project     = var.project
  region      = var.zone
}

provider "google-beta" {
  project     = var.project
  region      = var.zone
}

# Google Cloud Source Repository
resource "google_sourcerepo_repository" "repo" {
  name = var.repository_name
}

# Access control bucketille
resource "google_storage_bucket_access_control" "public_rule" {
  bucket = google_storage_bucket.bucket.name
  role   = "OWNER"
  entity = "allUsers"
}

# Ämpäri jossa koodit funktioille????
resource "google_storage_bucket" "bucket" {
  provider = google
  name     = "juukeli-bucket-nro-666"
}

# Laitetaan koodit ämpäriin????
resource "google_storage_bucket_object" "archive" {
  provider = google
  name     = "hannibal-funktio.zip"
  bucket   = google_storage_bucket.bucket.name
  source   = "../functions/hannibal-funktio.zip"
}

# luo funktio zipistä joka on bucketissa?????
resource "google_cloudfunctions_function" "function" {
  provider    = google
  name        = "hannibal-funktio"
  description = "testi"
  runtime     = "python38"
  project     =  var.project
  region      =  var.region

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name
  trigger_http          = true
  entry_point           = "hello_world"
}

# IAM entry for all users to invoke the function
# Pitää olla et toimii julkisesti nää funktiot????????
resource "google_cloudfunctions_function_iam_member" "invoker" {
  provider       = google
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

# API rakennus
resource "google_api_gateway_api" "hannibal-api" {
  provider     = google-beta
  api_id       = "hannibal-api"
}

# API config
resource "google_api_gateway_api_config" "hannibal-cnf" {
  provider      = google-beta
  api           = google_api_gateway_api.hannibal-api.api_id
  api_config_id = "config"

  openapi_documents {
    document {
      path     = "spec.yaml"
      contents = filebase64("./api-config.yaml")
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

# API Gateway
resource "google_api_gateway_gateway" "hannibal-gtw" {
  provider   = google-beta
  api_config = google_api_gateway_api_config.hannibal-cnf.api_config_id
  gateway_id = "gateway"
}
