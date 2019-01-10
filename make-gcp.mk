gcp-builds:
	gcloud builds submit --config services/${S}/cloudbuild.yaml . --substitutions BRANCH_NAME=master --project ${PROJECT}

gcp-compute-ssh:
	gcloud compute ssh ${I}

gcp-sql-connect:
	gcloud beta sql connect master3 --user=hexlet_basics --database=hexlet_basics_prod

gcp-setup:
	cd terraform && terraform apply
