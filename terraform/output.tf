output "namespace" {
value = data.kubernetes_resource.namespace.object.metadata.name
}

output "deployment_name" {
value = data.kubernetes_resource.deployment.object.metadata.name
}

output "cluster_ip" {
value = data.kubernetes_resource.service.object.spec.clusterIP
}

output "port" {
value = data.kubernetes_resource.deployment.object.spec.template.spec.containers[0].ports[0].containerPort
}