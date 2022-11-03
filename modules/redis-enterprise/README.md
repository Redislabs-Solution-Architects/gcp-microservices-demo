<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_redis_subscription_name"></a> [redis\_subscription\_name](#input\_redis\_subscription\_name) | The name of the Redis Enterprise Cloud Subscription | `string` | n/a | yes |
| <a name="input_redis_subscription_cidr"></a> [redis\_subscription\_cidr](#input\_redis\_subscription\_cidr) | The name of the Redis Enterprise Cloud Subscription deployment's CIDR | `string` | n/a | yes |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | The region to deploy the cluster in | `string` | n/a | yes |
| <a name="input_redis_secret_key"></a> [redis\_secret\_key](#input\_redis\_secret\_key) | The type of Redis DB to be deployed Options are 'OSS' or 'Ent' | `string` | n/a | yes |
| <a name="input_redis_access_key"></a> [redis\_access\_key](#input\_redis\_access\_key) | The type of Redis DB to be deployed Options are 'OSS' or 'Ent' | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_private_endpoint"></a> [db\_private\_endpoint](#output\_db\_private\_endpoint) | The Redis DB endpoint |
| <a name="output_db_password"></a> [db\_password](#output\_db\_password) | The Redis DB Password |
| <a name="output_redis_connection_string"></a> [redis\_connection\_string](#output\_redis\_connection\_string) | The connection string used in the 'Cart Service' to connect to redis |
| <a name="output_redis_subscription_id"></a> [redis\_subscription\_id](#output\_redis\_subscription\_id) | The Redis subscription ID |
<!-- END_TF_DOCS -->
