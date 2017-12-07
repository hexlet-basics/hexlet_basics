ansible-encrypt:
	ansible-vault encrypt ansible/production/group_vars/all/vault.yml



ansible-decrypt:
	ansible-vault decrypt ansible/production/group_vars/all/vault.yml
