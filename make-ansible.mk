U := ubuntu

ansible-deps-install:
	ansible-galaxy install -r requirements.yml

ansible-site-setup:
	ansible-playbook ansible/site.yml -i ansible/production -u $U

ansible-site-deploy:
	ansible-playbook ansible/deploy.yml -i ansible/production -u $U

ansible-vaults-encrypt:
	ansible-vault encrypt ansible/production/group_vars/all/vault.yml
	ansible-vault encrypt ansible/development/group_vars/all/vault.yml

ansible-vaults-decrypt:
	ansible-vault decrypt ansible/production/group_vars/all/vault.yml
	ansible-vault decrypt ansible/development/group_vars/all/vault.yml

ansible-development-setup:
	ansible-playbook ansible/development.yml -i ansible/development -vv

ansible-terraform-vars-generate:
	ansible-playbook ansible/terraform.yml -i ansible/production -vv
