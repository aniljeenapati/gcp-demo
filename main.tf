provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_compute_instance_template" "default" {
  name_prefix  = "py-temp"
  machine_type = "e2-medium"

  disk {
    auto_delete  = true
    boot         = true
    source_image = "projects/debian-cloud/global/images/family/debian-11"
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = <<-EOF
  #!/bin/bash
  exec > /var/log/startup-script.log 2>&1

  apt update
  apt install -y python3-pip git

  cd /opt
  git clone https://github.com/aniljeenapati/gcp-demo.git
  cd gcp-demo

  pip3 install flask

  nohup python3 app.py --host=0.0.0.0 --port=80 &
  EOF
}

resource "google_compute_instance_group_manager" "default" {
  name               = "flask-gm"
  base_instance_name = "flask-app"
  zone               = var.zone       # use zone here, NOT region
  version {
    instance_template = google_compute_instance_template.default.self_link
  }
  target_size = 2
}

resource "google_compute_health_check" "default" {
  name = "flask-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 3
  http_health_check {
    port         = 80
    request_path = "/"
  }
}

resource "google_compute_backend_service" "default" {
  name                  = "flask-backend"
  health_checks         = [google_compute_health_check.default.id]
  load_balancing_scheme = "EXTERNAL"
  backend {
    group = google_compute_instance_group_manager.default.instance_group
  }
}

resource "google_compute_url_map" "default" {
  name            = "flask-url-map"
  default_service = google_compute_backend_service.default.id
}

resource "google_compute_target_http_proxy" "default" {
  name    = "flask-http-proxy"
  url_map = google_compute_url_map.default.id
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "flask-forwarding-rule"
  target     = google_compute_target_http_proxy.default.id
  port_range = "80"
}

output "load_balancer_ip" {
  value = google_compute_global_forwarding_rule.default.ip_address
}
