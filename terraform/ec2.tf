resource "aws_instance" "hexlet-basics-web2" {
  ami           = "ami-e22aaa8d"
  instance_type = "t2.medium"
  subnet_id = "${aws_subnet.hexlet-basics-app-b.id}"
  associate_public_ip_address = true
  key_name = "${aws_key_pair.kirillm.id}"
  iam_instance_profile = "${aws_iam_instance_profile.webserver.name}"
  root_block_device = {
    volume_size = 20
  }
  vpc_security_group_ids = [
    "${aws_security_group.hexlet-basics-ssh.id}",
    "${aws_security_group.hexlet-basics-http.id}"
  ]

  tags {
    Name = "hexlet-basics-web"
    Project = "hexlet-basics"
  }
}

resource "aws_lb" "hexlet-basics" {
  name               = "hexlet-basics"
  internal        = false

  security_groups = ["${aws_security_group.hexlet-basics-http.id}"]
  subnets = ["${aws_subnet.hexlet-basics-app-a.id}", "${aws_subnet.hexlet-basics-app-b.id}"]
  tags {
    Name = "hexlet-basics"
    Project = "hexlet-basics"
  }
}

resource "aws_lb_target_group" "hexlet-basics" {
  name     = "hexlet-basics"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.hexlet-basics.id}"
}

resource "aws_lb_target_group_attachment" "hexlet-basics" {
  target_group_arn = "${aws_lb_target_group.hexlet-basics.arn}"
  target_id        = "${aws_instance.hexlet-basics-web2.id}"
  port             = 80
}

resource "aws_lb_listener" "hexlet-basics" {
  load_balancer_arn = "${aws_lb.hexlet-basics.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.hexlet-basics.arn}"
    type             = "forward"
  }
}
