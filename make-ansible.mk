ansible-deps-install:
	ansible-galaxy install -r requirements.yml

ansible-vaults-encrypt:
	ansible-vault encrypt ansible/production/group_vars/all/vault.yml
	# ansible-vault encrypt ansible/development/group_vars/all/vault.yml

ansible-vaults-decrypt:
	ansible-vault decrypt ansible/production/group_vars/all/vault.yml
	# ansible-vault decrypt ansible/development/group_vars/all/vault.yml

ansible-terraform-vars-generate:
	ansible-playbook ansible/terraform.yml -i ansible/production -vv



