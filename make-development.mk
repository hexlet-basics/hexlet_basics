development-setup:
	mkdir -p tmp
	touch tmp/ansible-vault-password
	docker run -v $(CURDIR):/app -w /app williamyeh/ansible:ubuntu18.04 ansible-playbook ansible/development.yml -i ansible/development -vv -K
