S := app

gcloud-init:
	gcloud container clusters get-credentials hexlet-basics

gcloud-builds:
	gcloud builds submit --config services/${S}/cloudbuild.yaml .

gcloud-compute-ssh:
	gcloud compute ssh ${I}
