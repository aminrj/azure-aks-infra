variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "aks-poc"
}

variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "swedencentral"
}

variable "kubernetes_cluster_name" {
  type    = string
  default = "my-aks-cluster"
}

variable "kubernetes_rbac_admin_groups" {
  type    = string
  default = "kubernetes-rbac-admin-groups"
}