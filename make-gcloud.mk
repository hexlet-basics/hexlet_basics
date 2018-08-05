S := app

gcloud-builds:
	gcloud builds submit --config services/${S}/cloudbuild.yaml .

gcloud-compute-ssh:
	gcloud compute ssh ${I}
