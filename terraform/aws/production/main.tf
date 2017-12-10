provider "aws" {
	version = "~> 1.5"
	region = "eu-central-1"
}

resource "aws_instance" "hexlet-basics-web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.small"
  subnet_id = "${aws_subnet.hexlet-basics-app-a.id}"
  associate_public_ip_address = true
  key_name = "${aws_key_pair.kirillm.id}"
  vpc_security_group_ids = [
    "${aws_security_group.hexlet-basics-ssh.id}",
    "${aws_security_group.hexlet-basics-http.id}"
  ]

  tags {
    Name = "hexlet-basics-web-a"
  }
}
