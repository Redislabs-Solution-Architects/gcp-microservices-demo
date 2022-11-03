output "db_private_endpoint" {
  value       = rediscloud_subscription_database.mc-example.private_endpoint
  description = "The Redis DB endpoint"
}

output "db_password" {
  value       = rediscloud_subscription_database.mc-example.password
  sensitive   = true
  description = "The Redis DB Password"
}

output "redis_connection_string" {
  sensitive   = true
  value       = "${rediscloud_subscription_database.mc-example.private_endpoint},user=default,password=${rediscloud_subscription_database.mc-example.password}"
  description = "The connection string used in the 'Cart Service' to connect to redis"
}
