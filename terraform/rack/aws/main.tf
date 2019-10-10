terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
  version = "~> 2.22"
}

provider "external" {
  version = "~> 1.2"
}

provider "kubernetes" {
  version = "~> 1.8"

  config_path = var.kubeconfig
}

module "k8s" {
  source = "../k8s"

  providers = {
    kubernetes = kubernetes
  }

  domain     = var.domain
  kubeconfig = var.kubeconfig
  name       = var.name
  release    = var.release
}

module "api" {
  source = "../../api/aws"

  providers = {
    aws        = aws
    kubernetes = kubernetes
  }

  domain     = var.domain
  kubeconfig = var.kubeconfig
  name       = var.name
  namespace  = module.k8s.namespace
  nodes_role = var.nodes_role
  release    = var.release
  router     = module.router.endpoint
}

module "router" {
  source = "../../router/aws"

  providers = {
    aws        = aws
    kubernetes = kubernetes
  }

  name               = var.name
  namespace          = module.k8s.namespace
  nodes_role         = var.nodes_role
  nodes_security     = var.nodes_security
  release            = var.release
  subnets            = var.subnets_public
  target_group_http  = var.target_group_http
  target_group_https = var.target_group_https
}
