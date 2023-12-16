# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "resource_group_nodes" {
  value = data.azurerm_resource_group.nodes.name
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.main.name
}