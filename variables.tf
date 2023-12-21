# variable "resource_group_name" {
#   description = "The name of the resource group"
#   type        = string
#   default     = "aks-poc"
# }

# variable "location" {
#   description = "The location of the resources"
#   type        = string
#   default     = "swedencentral"
# }

# variable "kubernetes_cluster_name" {
#   type    = string
#   default = "my-aks-cluster"
# }

variable "kubernetes_rbac_admin_groups" {
  type    = string
  default = "kubernetes-rbac-admin-groups"
}

variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
  default     = 2
}

variable "msi_id" {
  type        = string
  description = "The Managed Service Identity ID. Set this value if you're running this example using Managed Identity as the authentication method."
  default     = null
}

variable "username" {
  type        = string
  description = "The admin username for the new cluster."
  default     = "azureadmin"
}