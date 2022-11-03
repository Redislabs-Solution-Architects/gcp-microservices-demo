resource "null_resource" "set_gke_creds" {
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${var.cluster_name} --region ${var.gcp_region} --project ${var.gcp_project_id}"
  }
}

resource "null_resource" "install_nginx" {
  depends_on = [
    null_resource.set_gke_creds
  ]
  provisioner "local-exec" {
    command = <<-EOT
        helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx && \
        helm repo update && \
        helm install ingress-nginx ingress-nginx/ingress-nginx --create-namespace --namespace ingress-nginx --set rbac.create=true
    EOT
  }
}

data "template_file" "cm_prod_issuer" {
  template = file("${path.module}/templates/cert-manager/prod_issuer.yaml")
  vars = {
    email_address = var.email_address
  }
}

resource "null_resource" "install_cert_manager" {
  depends_on = [
    null_resource.set_gke_creds
  ]
  provisioner "local-exec" {
    command = <<-EOT
            kubectl apply --validate=false -f https://github.com/cert-manager/cert-manager/releases/download/${var.cert_manager_version}/cert-manager.yaml && \
            
                kubectl -n cert-manager wait --for condition=Available --timeout=300s deploy/cert-manager-webhook && \
            cat <<-EOF | kubectl apply -f -
            ${data.template_file.cm_prod_issuer.rendered}
            EOF
        EOT
  }
}

resource "null_resource" "install_external_dns" {
  depends_on = [
    null_resource.set_gke_creds
  ]
  provisioner "local-exec" {
    command = <<-EOT
        helm repo add bitnami https://charts.bitnami.com/bitnami && \
        helm repo update && \
        helm install external-dns bitnami/external-dns --create-namespace -n external-dns --set provider=google --set triggerLoopOnEvent=true --set google.project=${var.gcp_project_id}
    EOT
  }
}

data "template_file" "shopping_cart" {
  template = file("${path.module}/templates/shopping-cart/shopping-cart.yaml")
  vars = {
    redis_connection_string = var.redis_connection_string
    fqdn                    = var.domain_name
  }
}

resource "null_resource" "deploy_shopping_cart" {
  depends_on = [
    null_resource.install_cert_manager,
    null_resource.install_nginx,
    null_resource.install_external_dns
  ]
  provisioner "local-exec" {
    command = <<-EOT
        kubectl -n ingress-nginx wait --for condition=Available --timeout=300s deploy/ingress-nginx-controller && \
        sleep 5 && \
        cat <<-EOF | kubectl apply -f -
        ${data.template_file.shopping_cart.rendered}
        EOF
    EOT
  }
}
