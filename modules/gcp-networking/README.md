<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The GKE Cluster Name | `string` | n/a | yes |
| <a name="input_gcp_project_id"></a> [gcp\_project\_id](#input\_gcp\_project\_id) | The project ID to deploy the cluter into | `string` | n/a | yes |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | The GCP Region | `string` | `"us-central1"` | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gcp_network_name"></a> [gcp\_network\_name](#output\_gcp\_network\_name) | The name of the GCP Network |
| <a name="output_gcp_subnet_name"></a> [gcp\_subnet\_name](#output\_gcp\_subnet\_name) | The name of the GCP Subnet |
<!-- END_TF_DOCS -->
