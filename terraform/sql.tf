resource "google_sql_database_instance" "master" {
  project          = "${var.project_name}"
  name             = "master3"
  database_version = "POSTGRES_9_6"
  region           = "${var.region}"

  settings {
    tier              = "db-f1-micro"
    availability_type = "REGIONAL"

    backup_configuration {
      enabled = true
    }
  }
}

resource "google_sql_user" "hexlet_basics" {
  project  = "${var.project_name}"
  name     = "hexlet_basics"
  instance = "${google_sql_database_instance.master.name}"
  password = "${var.db_password}"
}

resource "google_sql_database" "hexlet_basics_prod" {
  project  = "${var.project_name}"
  name     = "${var.db_name}"
  instance = "${google_sql_database_instance.master.name}"
}
