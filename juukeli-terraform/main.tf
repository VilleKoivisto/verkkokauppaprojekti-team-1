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

#Asetetaan credentiaalit, projekti ja oletusalueet
provider "google" {
  credentials = file(var.credentials_file)

  project = var.project
  region  = var.region
  zone    = var.zone
}

#Asetetaan credentiaalit, projekti ja oletusalueet, google-betaa käytetään apin luomisessa
provider "google-beta" {
  credentials = file(var.credentials_file)

  project = var.project
  region  = var.region
  zone    = var.zone
}

#luodaan ämpäri jonne koodi laitetaan
resource "google_storage_bucket" "bucket" {
  provider = google
  name     = "juukeli-ampari2"
  location = "EU"
}

#luodaan storage object
resource "google_storage_bucket_object" "juukeli" {
  provider  = google
  name      = "juukeli"
  bucket    = google_storage_bucket.bucket.name
  source    = "./juukeli.zip"
}

#luo funktion zipistä
resource "google_cloudfunctions_function" "function" {
  provider    = google
  name        = "juukeli-funktio"
  description = "Testataan funtkion tuuppaamista gcp:hen terraformilla"
  runtime     = "python39"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.juukeli.name
  trigger_http          = true
  entry_point           = "juukeli"
}

# IAM entry for all users to invoke the function
# tää pitää olla jotta on julkisesti saatavilla
resource "google_cloudfunctions_function_iam_member" "invoker" {
  provider       = google
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

#Luodaan API Gateway
resource "google_api_gateway_api" "hannibal_api" {
  provider = google-beta
  api_id = "hannibal-api"
}

#api gateway
resource "google_api_gateway_api_config" "hannibal_api" {
  provider = google-beta
  api = google_api_gateway_api.hannibal_api.api_id
  api_config_id = "config"

  openapi_documents {
    document {
      path = "spec.yaml"
      contents = filebase64("./api-config.yaml")
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_api_gateway_gateway" "hannibal_api" {
  provider = google-beta
  api_config = google_api_gateway_api_config.hannibal_api.id
  gateway_id = "hannibal-gateway"
}
