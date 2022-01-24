resource "random_id" "db_name_suffix" {
  byte_length = 4
}

locals {
  onprem = ["213.127.1.96"]
}

resource "google_sql_database_instance" "postgres" {
  name                = "postgres-instance-${random_id.db_name_suffix.hex}"
  database_version    = "POSTGRES_14"
  deletion_protection = false

  settings {
    tier = "db-g1-small"

    maintenance_window {
      day  = "1"
      hour = "4"
    }

    backup_configuration {
      enabled    = true
      start_time = "04:30"
    }

    ip_configuration {
      dynamic "authorized_networks" {
        for_each = local.onprem
        iterator = onprem

        content {
          name  = "onprem-${onprem.key}"
          value = onprem.value
        }
      }
      private_network = google_compute_network.vpc.id
    }
  }
}

resource "google_sql_user" "users" {
  name     = "warehouse_user"
  instance = google_sql_database_instance.postgres.name
  password = "warehouse_user_password"
}

resource "google_sql_database" "database" {
  name     = "warehouse_db"
  instance = google_sql_database_instance.postgres.name
  charset  = "UTF8"
  lifecycle {
    prevent_destroy = true
  }
}