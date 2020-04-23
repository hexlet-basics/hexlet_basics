resource "digitalocean_kubernetes_cluster" "hexlet_basics" {
  version = "1.16.6-do.2"

  name = "hexlet-basics"
  region = "fra1"

  node_pool {
    name       = "hexlet-basics-node-pool"
    size       = "s-2vcpu-4gb"
    node_count = 1
  }
}
