output "akp_kargo_instance_name" {
  value = data.akp_kargo_instance.control-plane.name
}

output "akp_argocd_instance_name" {
  value = data.akp_instance.control-plane.name
}

output "datadog_user_id" {
  value = data.datadog_users.test.users[0].id
}