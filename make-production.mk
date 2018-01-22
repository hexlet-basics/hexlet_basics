U := ubuntu
# E := development

production-exercises-load:
	ansible-playbook ansible/exercises.yml -i ansible/production -u $U -vvv --ask-vault-pass

production-setup:
	ansible-playbook ansible/site.yml -i ansible/production -u $U

production-env-update:
	ansible-playbook ansible/deploy.yml -i ansible/production -u $U --tag env

# production-update-exercise-images:
# 	ansible-playbook ansible/site.yml -i ansible/production -u $U --tag images

production-deploy:
	ansible-playbook ansible/deploy.yml -i ansible/production -u $U --ask-vault-pass
