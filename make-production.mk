U := ubuntu
VPF := tmp/ansible-vault-password
# E := development

production-exercises-load:
	ansible-playbook ansible/exercises.yml -i ansible/production -u $U -vv --vault-password-file=$(VPF)

production-setup:
	ansible-playbook ansible/site.yml -i ansible/production -u $U --vault-password-file=$(VPF)

production-env-update:
	ansible-playbook ansible/deploy.yml -i ansible/production -u $U --tag env --vault-password-file=$(VPF)

# production-update-exercise-images:
# 	ansible-playbook ansible/site.yml -i ansible/production -u $U --tag images

production-deploy:
	ansible-playbook ansible/deploy.yml -i ansible/production -u $U --vault-password-file=$(VPF)
