ansible-encrypt:
	ansible-vault encrypt ansible/production/group_vars/all/vault.yml
	ansible-vault encrypt ansible/development/group_vars/all/vault.yml

ansible-decrypt:
	ansible-vault decrypt ansible/production/group_vars/all/vault.yml
	ansible-vault decrypt ansible/development/group_vars/all/vault.yml

ansible-generate-env:
	ansible-playbook ansible/env.yml -i ansible/development -vv
