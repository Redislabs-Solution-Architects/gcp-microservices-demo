# Scaling Microservices Applications: Migration to Redis Enterprise on Google Cloud
  
This demo repo shows you how to deploy a fully functioning microservices application on Google Cloud using Open Source Redis and migrate the data to Redis Enterprise with minimal downtime. 

![Redis Enterprise for Online Boutique Mircoservices App](./img/redis-enterprise.png)

## Prerequisites 
### Software to Install
`Only Linux has been tested`
* [gcloud command line](https://cloud.google.com/sdk/docs/install)
* [terraform](https://www.terraform.io/downloads)
* [kubectl](https://kubernetes.io/docs/tasks/tools/)
* [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### Accounts Needed
* [Google Cloud Account](https://console.cloud.google.com/)
* [Redis Enterprise in Google Marketplace Account](https://console.cloud.google.com/marketplace/product/redis-marketplace-isaas/redis-enterprise-cloud-flexible-plan)
### Information to Gather
#### Redis Enterprise in Google Cloud Marketplace
* [REDISCLOUD_ACCESS_KEY](https://docs.redis.com/latest/rc/api/get-started/enable-the-api/)
* [REDISCLOUD_SECRET_KEY](https://docs.redis.com/latest/rc/api/get-started/manage-api-keys/#secret)
#### Google Cloud
* Project ID
* Region
  
    
## Deployment
### Clone the Repo
```bash
git clone https://github.com/Redislabs-Solution-Architects/gcp-microservices-demo.git
pushd gcp-microservices-demo
```
### Update the *terraform.tfvars.json*
The following values will need to be modified by you.
```bash
"cluster_name": "The name of the GKE cluster",
"gcp_project_id": "The project ID to deploy the cluster into",
"gcp_region": "The region to deploy the cluster in",
"gke_node_count": "The number of nodes to deploy in the cluster",
"gke_release_channel": "The gke release channel to deploy",
"gke_machine_type": "The type of machine to deploy",
"redis_subscription_name": "The name of the Redis Enterprise Subscription",
"redis_subscription_cidr": "The Redis Enterprise Subscription deployment's CIDR"
```
### Initialize Terraform
```bash
terraform init
```
### Deploy the stack
```bash
terraform apply --auto-approve
```
### What success looks like  
```bash
Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

Outputs:

db_password = <sensitive>
db_private_endpoint = "redis-19574.internal.c21702.us-central1-1.gcp.cloud.rlrcp.com:19574"
gke_cluster_name = "gke-online-boutique"
region = "us-central1"
```

### Store Redis Enterprise database information in environment variables for later use
```bash
export REDIS_DEST=`terraform output db_private_endpoint | tr -d '"'`
export REDIS_DEST_PASS=`terraform output db_password | tr -d '"'`
```
       
### Target your environment to the GKE cluster
```bash
gcloud container clusters get-credentials \
$(terraform output -raw gke_cluster_name) \
--region $(terraform output -raw region)
```
  
   
## Run the demo
### Clone the microserivces demo repo
```bash
popd
git clone https://github.com/gmflau/microservices-demo.git
pushd microservices-demo/kustomize
```
  
### Deploy the microserices demo app `Online Boutique` using the default OSS Redis as shopping cart 
To see what the default Kustomize configuration defined by kustomize/kustomization.yaml will generate (without actually deploying them yet).
```bash
kubectl kustomize .
```
Apply the default Kustomize configuration (kustomize/kustomization.yaml) to use the OSS Redis as shopping cart.
```bash
kubectl apply -k .
```
Wait for all Pods to show `STATUS` of `Running`.
```bash
kubectl get pods
```
The output should be similar to the following:
```
NAME                                     READY   STATUS    RESTARTS   AGE
adservice-67f7969f6d-8xh4p               1/1     Running   0          80s
cartservice-866466c9d8-lrzcx             1/1     Running   0          79s
checkoutservice-676b964c46-pl68q         1/1     Running   0          78s
currencyservice-779fb5bb64-k8mbc         1/1     Running   0          77s
emailservice-7d597f846b-hvv5m            1/1     Running   0          76s
frontend-7684ff6c58-pcp5m                1/1     Running   0          75s
loadgenerator-7f8d4c9b46-58lcn           1/1     Running   0          75s
paymentservice-7d49db6cf6-ffvls          1/1     Running   0          74s
productcatalogservice-7645c9696d-kshnd   1/1     Running   0          73s
recommendationservice-5ff65b7856-6wxxd   1/1     Running   0          72s
redis-cart-6f65887b5d-dc6wq              1/1     Running   0          71s
shippingservice-5c674c976-tfvq9          1/1     Running   0          70s
```
  
_Note: It may take 2-3 minutes before the changes are reflected on the deployment._

Access the web frontend in a browser using the frontend's EXTERNAL_IP
```
kubectl get service frontend-external | awk '{print $4}'
```
  
### Migrate the shopping cart data from OSS Redis to Redis Enterpirse in Google Cloud Marketplace
Create a K8 secret for Redis Enterprise database connection
```bash
kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: redis-creds
type: Opaque
stringData:
  REDIS_SOURCE: redis://redis-cart:6379
  REDIS_DEST: redis://${REDIS_DEST}
  REDIS_DEST_PASS: ${REDIS_DEST_PASS}
EOF
```   
Run a K8 job to migrate data from OSS Redis to Redis Enterprise database
```bash
kubectl apply -f https://raw.githubusercontent.com/Redislabs-Solution-Architects/gcp-microservices-demo/main/redis-migrator-job.yaml
```

### Delete local redis-cart based on OSS Redis
```bash
kubectl delete deploy redis-cart
```
 
### Configure the shopping cart with Redis Enterprise database via Kustomize
```bash
kustomize edit add component components/redis-enterprise
```
  
This will update the kustomize/kustomization.yaml file which could be similar to:
```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
- base
components:
- components/redis-enterprise
```

Update current Kustomize manifest to target this fully managed Redis Enterprise database instance Construct the connection string for the fully managed Redis Enterprise database instance:
```bash
export REDIS_IP="${REDIS_DEST},user=default,password=${REDIS_DEST_PASS}"
```  
Update components/redis-enterprise/kustomization.yaml with the Redis Enterprise database's connection string:
```bash
sed -i .bak "s/REDIS_CONNECTION_STRING/${REDIS_IP}/g" components/redis-enterprise/kustomization.yaml
```

Render to review the deployment manifest by running:
```bash
kubectl kustomize .
```
  
Deploy to make the Redis Enterprise database as the backend store for the shopping cart:
```bash
kubectl apply -k .
```

 
