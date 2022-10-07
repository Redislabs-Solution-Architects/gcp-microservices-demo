output "db_private_endpoint" {
  value = rediscloud_subscription_database.mc-example.private_endpoint
}

output "db_password" {
  value = rediscloud_subscription_database.mc-example.password
  sensitive = true
}

