
resource "helm_release" "argocd" {
  name = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "3.35.4"

  values = [file("values/argocd.yaml")]
}

# Kubernetes Ingress resource to publish ArgoCD
resource "kubernetes_ingress_v1" "argocd_ingress" {
  metadata {
    name      = "argocd-server-ingress"
    namespace = "argocd"
    annotations = {
      "cert-manager.io/cluster-issuer" = "letsencrypt-staging"
      #   "nginx.ingress.kubernetes.io/ssl-passthrough" = "true"
      "nginx.ingress.kubernetes.io/backend-protocol"   = "HTTP"
      "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true"
    }
  }

  spec {
    ingress_class_name = "external-nginx"
    rule {
      host = "argocd.labs.molntek.com"
      http {
        path {
          backend {
            service {
              name = "argocd-server"
              port {
                name = "http"
              }
            }
          }
          path = "/"
        }
      }
    }
    tls {
      hosts       = ["argocd.labs.molntek.com"]
      secret_name = "labs-molntek-com"
    }
  }
  depends_on = [helm_release.argocd]
}