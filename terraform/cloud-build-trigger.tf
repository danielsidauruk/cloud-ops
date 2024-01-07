resource "google_cloudbuild_trigger" "this" {
  name        = var.trigger_name
  description = "Trigger for repository events"
  
  depends_on = [google_project_service.this["cloudbuild"]]

  source_to_build {
    uri       = var.github_repo_url
    ref       = "refs/heads/main"
    repo_type = "GITHUB"
  }

  git_file_source {
    path      = "cloudbuild.yaml"
    uri       = var.github_repo_url
    revision  = "refs/heads/main"
    repo_type = "GITHUB"
  }
}