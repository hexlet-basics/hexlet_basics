kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'

helm repo add rimusz https://charts.rimusz.net
helm repo update

https://medium.com/@at_ishikawa/enable-https-by-cert-manager-on-gke-3996f84fffe5
