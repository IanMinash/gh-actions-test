terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.36.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.37.1"
    }
  }

  backend "azurerm" {
    resource_group_name  = "devops-course"
    storage_account_name = "devopscoursesa"
    container_name       = "tfstates"
    key                  = "my-flask-app.tfstate"
  }
}


provider "azurerm" {
  # Configuration options
  features {

  }

  subscription_id = var.az_subscription_id
}


module "aks_cluster" {
  source = "../aks"
}

data "azurerm_kubernetes_cluster" "default" {
  depends_on          = [module.aks_cluster]
  name                = module.aks_cluster.cluster_name
  resource_group_name = module.aks_cluster.rg_name
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.default.kube_config.0.host
  username               = data.azurerm_kubernetes_cluster.default.kube_config.0.username
  password               = data.azurerm_kubernetes_cluster.default.kube_config.0.password
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)
}

resource "kubernetes_namespace" "flaskapp_ns" {
  metadata {
    name = "flaskapp-ns"
  }
}

resource "kubernetes_secret" "flaskapp_registry_creds" {
  metadata {
    name      = "fe-registry-creds"
    namespace = kubernetes_namespace.flaskapp_ns.metadata.0.name
  }

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${var.registry}" = {
          username = "${var.registry_username}"
          password = "${var.registry_password}"
          email    = "${var.registry_email}"
        }
      }
    })
  }

  type = "kubernetes.io/dockerconfigjson"
}



resource "kubernetes_deployment" "flaskapp_deployment" {
  metadata {
    name      = "flaskapp-deployment"
    namespace = kubernetes_namespace.flaskapp_ns.metadata.0.name
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        application = "flaskapp"
        type        = "backend"
      }
    }

    template {
      metadata {
        labels = {
          application = "flaskapp"
          type        = "backend"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret.flaskapp_registry_creds.metadata.0.name
        }

        container {
          image = var.image_url
          name  = "flaskapp-container"

          port {
            container_port = 5000
          }

        #   TODO: Create Redis Deployment & Service & uncomment this section
        #   env {
        #     name  = "REDIS_HOST"
        #     value = kubernetes_service.flaskapp_redis_service.metadata.0.name
        #   }
        }
      }
    }
  }
}

resource "kubernetes_service" "flaskapp_service" {
  metadata {
    name      = "flaskapp-service"
    namespace = kubernetes_namespace.flaskapp_ns.metadata.0.name
  }

  spec {
    selector = {
      application = "flaskapp"
      type        = "backend"
    }

    port {
      target_port = 5000
      port        = 5000
    }

    type = "LoadBalancer"
  }
}

# TODO: Attach this PVC to a Redis deployment
resource "kubernetes_persistent_volume_claim" "flaskapp_redis_pvc" {
  metadata {
    name      = "flaskapp-redis-pvc"
    namespace = kubernetes_namespace.flaskapp_ns.metadata.0.name
  }

  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "256Mi"
      }
    }
  }

  wait_until_bound = false
}