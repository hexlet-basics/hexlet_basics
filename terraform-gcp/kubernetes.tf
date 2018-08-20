resource "kubernetes_secret" "cloudsql_db_credentials" {
  depends_on = ["google_container_cluster.hexlet_basics"]
   "metadata" {
       name = "cloudsql-db-credentials"
   }


   data {
       username = "${var.db_username}"
       password = "${var.db_password}"
   }
 }


resource "kubernetes_secret" "cloudsql_instance_credentials" {
  depends_on = ["google_container_cluster.hexlet_basics"]
	metadata {
		name = "cloudsql-instance-credentials"
	}
	data {
		credentials.json = "${base64decode(google_service_account_key.cloudsql_proxy.private_key)}"
	}
}

# resource "kubernetes_secret" "external_dns_credentials" {
#   depends_on = ["google_container_cluster.hexlet_basics"]
# 	metadata {
# 		name = "external-dns-credentials"
# 	}
# 	data {
# 		credentials.json = "${base64decode(google_service_account_key.external_dns.private_key)}"
# 	}
# }

resource "kubernetes_secret" "cloudflare_credentials" {
  depends_on = ["google_container_cluster.hexlet_basics"]
	metadata {
		name = "cloudflare-credentials"
	}
	data {
		api_key = "${var.cloudflare_api_key}"
		email = "${var.cloudflare_email}"
	}
}

