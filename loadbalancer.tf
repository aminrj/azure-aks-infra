# Reference to the AKS cluster
data "azurerm_kubernetes_cluster" "this" {
  name                = "${local.env}-${local.aks_name}"
  resource_group_name = local.resource_group_name

  depends_on = [azurerm_kubernetes_cluster.main]
}

provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.this.kube_config.0.host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.this.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.this.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.this.kube_config.0.cluster_ca_certificate)
  }
}

# External nginx
resource "helm_release" "external_nginx" {
  name = "external"

  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress"
  create_namespace = true
  version          = "4.8.0"

  values = [file("${path.module}/values/ingress.yaml")]
}

# Cert manager
resource "helm_release" "cert_manager" {
  name = "cert-manager"

  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true
  version          = "v1.13.1"

  set {
    name  = "installCRDs"
    value = "true"
  }
}

# External DNS
# resource "helm_release" "external_dns" {
#   name = "external-dns"

#   repository       = "https://charts.bitnami.com/bitnami"
#   chart            = "external-dns"
#   namespace        = "external-dns"
#   create_namespace = true
#   version          = "6.28.6"

#   values = [file("${path.module}/values/external-dns.yaml")]
# }