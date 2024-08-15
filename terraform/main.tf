terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.32.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 1.8.0"
    }
  }
}

locals {
    info = jsonencode({
    "name"=data.kubernetes_resource.namespace.object.metadata.name,
    "namespace"=data.kubernetes_resource.namespace.object.metadata.name,
    "cluster_ip"= data.kubernetes_resource.service.object.spec.clusterIP,
    "port"=data.kubernetes_resource.deployment.object.spec.template.spec.containers[0].ports[0].containerPort
    }
  )
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

data "kubernetes_resource" "namespace" {
  api_version    = "v1"
  kind           = "Namespace"
  metadata {
    name      = "hello-sre"
  }
}

data "kubernetes_resource" "deployment" {
  api_version = "apps/v1"
  kind        = "Deployment"

  metadata {
    name      = "hello-sre"
    namespace = "hello-sre"
  }
}

data "kubernetes_resource" "service" {
  api_version = "v1"
  kind        = "Service"

  metadata {
    name      = "hello-sre"
    namespace = "hello-sre"
  }
}


resource "local_file" "info" {
  filename = "${path.module}/info.json"
  content = local.info
}