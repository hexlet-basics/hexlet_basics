ansible-deps-install:
	ansible-galaxy install -r requirements.yml

ansible-vaults-edit:
	ansible-vault edit ansible/production/group_vars/all/vault.yml --vault-password-file=tmp/ansible-vault-password

# ansible-vaults-encrypt:
# 	ansible-vault encrypt ansible/production/group_vars/all/vault.yml
# 	# ansible-vault encrypt ansible/development/group_vars/all/vault.yml

# ansible-vaults-decrypt:
# 	ansible-vault decrypt ansible/production/group_vars/all/vault.yml
# 	# ansible-vault decrypt ansible/development/group_vars/all/vault.yml

ansible-terraform-vars-generate:
	ansible-playbook ansible/terraform.yml -i ansible/production -vv --vault-password-file=tmp/ansible-vault-password

ansible-k8s-vars-generate:
	ansible-playbook ansible/k8s.yml -i ansible/production -vv --vault-password-file=tmp/ansible-vault-password
