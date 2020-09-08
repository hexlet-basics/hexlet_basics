resource "digitalocean_kubernetes_cluster" "hexlet_basics_3" {
  version = "1.18.8-do.0"

  name = "hexlet-basics-3"
  region = "fra1"

  node_pool {
    name       = "hexlet-basics-node-pool-2"
    size       = "c-2"
    auto_scale = true

    min_nodes  = 3
    max_nodes  = 3
  }
}
