data "archive_file" "github-login" {
type = "zip"
output_path = "../github-login/github-login.zip"
source_dir = "../github-login"
}

resource "google_storage_bucket" "bucket" {
  name = "naas-functions-bucket"
}

resource "google_storage_bucket_object" "archive" {
  name   = "github-login.zip"
  bucket = "${google_storage_bucket.bucket.name}"
  source = "../github-login/github-login.zip"
  depends_on = ["data.archive_file.github-login"]
}

resource "google_cloudfunctions_function" "function" {
  name              = "github-login-callback"
  project           = "naas-246111"
  region            = "${var.region}"
  runtime = var.runtime
  trigger_http      = true
  timeout           = var.function_timeout
  https_trigger_url = "${var.base_url}/login/callback"
entry_point = "Login"
source_archive_bucket = "${google_storage_bucket.bucket.name}"
source_archive_object = "${google_storage_bucket_object.archive.name}"
}
