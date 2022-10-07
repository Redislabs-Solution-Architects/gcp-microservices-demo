<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_redis_subscription_name"></a> [redis\_subscription\_name](#input\_redis\_subscription\_name) | The name of the Redis Enterprise Subscription | `string` | n/a | yes |
| <a name="input_redis_subscription_cidr"></a> [redis\_subscription\_cidr](#input\_redis\_subscription\_cidr) | The Redis Enterprise Subscription deployment's CIDR | `string` | n/a | yes |
| <a name="input_gcp_project_id"></a> [gcp\_project\_id](#input\_gcp\_project\_id) | The project ID to deploy the Redis Enterprise Cloud Subscription into | `string` | n/a | yes |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | The region to deploy the Redis Enterprise Cloud Subscription in | `string` | n/a | yes |
| <a name="input_gcp_network_name"></a> [gcp\_network\_name](#input\_gcp\_network\_name) | The name of the GCP Network | `string` | n/a | yes |
| <a name="input_gcp_subnet_name"></a> [gcp\_subnet\_name](#input\_gcp\_subnet\_name) | The name of the GCP Network Peering | `string` | n/a | yes |

   
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_private_endpoint"></a> [db\_private\_endpoint](#output\_db\_private\_endpoint) | Redis Enterprise DB private endpoint |
| <a name="output_db_password"></a> [db\_password](#output\_db\_password) | Redis Enterprise DB password |

<!-- END_TF_DOCS -->
