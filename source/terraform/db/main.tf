
# Projekti 4 / ryhmä 1 / Terraform-template for database
# -----------------------------------------------
# Templaten muuttujat määritellään tiedostossa "variables.tf"

# Provider-tiedot:
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.14.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project
  region      = var.region
  zone        = var.zone
}

# Luo SQL database instancen annetuilla tiedoilla
# tarkastaa luodaanko instanssi,database, user: jos deploy_db (variables.tf -tiedostossa) on false niin ei luoda, jos taas true niin luodaan

resource "google_sql_database_instance" "Postgreskanta" {
  count            = var.deploy_db ? 1 : 0 
  name             = "postgreskanta"
  database_version = "POSTGRES_13"
  region = var.region

  settings {
    tier = "db-f1-micro" # postgresql tukee vain shared core machineja! tämä shared-core löytyy haminasta
    ip_configuration {
      ipv4_enabled = true
      authorized_networks {
        name  = "all"
        value = "0.0.0.0/0"
      }
    }
  }
}

resource "google_sql_database" "elinkauppa" {
  count = var.deploy_db ? 1 : 0

  name     = "elinkauppa"
  project  = var.project
  instance = google_sql_database_instance.Postgreskanta[0].name

  depends_on = [google_sql_database_instance.Postgreskanta]
}

resource "google_sql_user" "default" {
  count = var.deploy_db ? 1 : 0

  project  = var.project
  name     = var.sql_name
  instance = google_sql_database_instance.Postgreskanta[0].name
  password = var.sql_password

  depends_on = [google_sql_database.elinkauppa]
}


