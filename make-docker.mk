docker-release:
	ansible-playbook ansible/release.yml -i ansible/development -vv
