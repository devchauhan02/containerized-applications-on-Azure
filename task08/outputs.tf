output "aci_fqdn" {
  description = "FQDN of the application running in Azure Container Instance."
  value       = module.aci.fqdn
}

output "aks_lb_ip" {
  description = "Load balancer public IP address for the AKS application service."
  value       = try(data.kubernetes_service_v1.app.status[0].load_balancer[0].ingress[0].ip, null)
}