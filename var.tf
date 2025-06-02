variable "project_id" {}
variable "region" {}
variable "zone" {}
variable "service_account_key" {}
variable "instance_template_name" { default = "flask-template" }
variable "instance_group_name"    { default = "flask-mig" }
variable "machine_type"           { default = "e2-medium" }
variable "image_family"           { default = "debian-11" }
variable "image_project"          { default = "debian-cloud" }
variable "app_repo_url"           {}
