S := app

gcloud-build:
	gcloud builds submit --config services/${S}/cloudbuild.yaml .
