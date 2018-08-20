S := app

gcloud-cluster-init:
	gcloud container clusters get-credentials hexlet-basics
	kubectl create clusterrolebinding cluster-admin-binding-$U --clusterrole cluster-admin --user $U

gcloud-builds:
	gcloud builds submit --config services/${S}/cloudbuild.yaml .

gcloud-compute-ssh:
	gcloud compute ssh ${I}
