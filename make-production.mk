U := ubuntu
# E := development

production-exercises-load:
	ansible-playbook ansible/exercises.yml -i ansible/production -u $U -vv --ask-vault-pass

production-site-setup:
	ansible-playbook ansible/site.yml -i ansible/production -u $U

production-site-update-env:
	ansible-playbook ansible/site.yml -i ansible/production -u $U --tag env

production-site-update-exercise-images:
	ansible-playbook ansible/site.yml -i ansible/production -u $U --tag images

production-site-deploy:
	ansible-playbook ansible/deploy.yml -i ansible/production -u $U --ask-vault-pass
