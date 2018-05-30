development-setup:
	mkdir tmp
	touch tmp/ansible-vault-password
	ansible-playbook ansible/development.yml -i ansible/development -vv -K
