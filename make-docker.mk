docker-release:
	ansible-playbook ansible/release.yml -i ansible/development -vv

docker-bash:
	docker run -it hexlet/hexlet-basics bash
