resource "aws_vpc" "hexlet-basics" {
	cidr_block = "172.16.0.0/24"
	# instance_tenancy = "dedicated"

	tags {
		Name = "hexlet-basics"
    Project = "hexlet-basics"
	}
}

resource "aws_internet_gateway" "hexlet-basics" {
  vpc_id = "${aws_vpc.hexlet-basics.id}"

  tags {
    Name = "hexlet-basics"
    Project = "hexlet-basics"
  }
}

resource "aws_subnet" "hexlet-basics-app-a" {
	vpc_id = "${aws_vpc.hexlet-basics.id}"
	cidr_block = "172.16.0.0/27"
	availability_zone = "eu-central-1a"

	tags {
		Name = "hexlet-basics-app-a"
    Project = "hexlet-basics"
	}
}

resource "aws_subnet" "hexlet-basics-app-b" {
	vpc_id = "${aws_vpc.hexlet-basics.id}"
	cidr_block = "172.16.0.32/27"
	availability_zone = "eu-central-1b"

	tags {
		Name = "hexlet-basics-app-b"
    Project = "hexlet-basics"
	}
}

resource "aws_subnet" "hexlet-basics-db-a" {
	vpc_id = "${aws_vpc.hexlet-basics.id}"
	cidr_block = "172.16.0.64/27"

	tags {
		Name = "hexlet-basics-db-a"
    Project = "hexlet-basics"
	}
}

resource "aws_subnet" "hexlet-basics-db-b" {
	vpc_id = "${aws_vpc.hexlet-basics.id}"
	cidr_block = "172.16.0.96/27"

	tags {
		Name = "hexlet-basics-db-b"
    Project = "hexlet-basics"
	}
}

resource "aws_security_group" "hexlet-basics-ssh" {
  name        = "hexlet-basics-ssh"
  description = "allow ssh"
  vpc_id      = "${aws_vpc.hexlet-basics.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

	tags {
		Name = "hexlet-basics-ssh"
    Project = "hexlet-basics"
	}
}

resource "aws_security_group" "hexlet-basics-http" {
  name        = "hexlet-basics-http"
  description = "allow http"
  vpc_id      = "${aws_vpc.hexlet-basics.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

	tags {
		Name = "hexlet-basics-http"
    Project = "hexlet-basics"
	}
}

resource "aws_main_route_table_association" "hexlet-basics" {
  vpc_id = "${aws_vpc.hexlet-basics.id}"
  route_table_id = "${aws_route_table.hexlet-basics.id}"
}

resource "aws_route_table" "hexlet-basics" {
  vpc_id = "${aws_vpc.hexlet-basics.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.hexlet-basics.id}"
  }

  # route {
  #   ipv6_cidr_block = "::/0"
  #   egress_only_gateway_id = "${aws_egress_only_internet_gateway.foo.id}"
  # }

  tags {
    Name = "hexlet-basics"
  }
}

resource "aws_security_group" "hexlet-basics-db" {
  name        = "hexlet-basics-db"
  description = "allow connect to db"
  vpc_id      = "${aws_vpc.hexlet-basics.id}"

	tags {
		Name = "hexlet-basics-db"
	}
}

resource "aws_security_group_rule" "allow-tcp" {
  type            = "ingress"
  from_port       = 0
  to_port         = 65535
  protocol        = "tcp"
  source_security_group_id = "${aws_security_group.hexlet-basics-http.id}"
  security_group_id = "${aws_security_group.hexlet-basics-db.id}"
}

resource "aws_security_group_rule" "allow-udp" {
  type            = "ingress"
  from_port       = 0
  to_port         = 65535
  protocol        = "udp"
  source_security_group_id = "${aws_security_group.hexlet-basics-http.id}"
  security_group_id = "${aws_security_group.hexlet-basics-db.id}"
}

resource "aws_security_group_rule" "allow-icmp" {
  type            = "ingress"
  from_port       = 0
  to_port         = 8
  protocol        = "icmp"
  source_security_group_id = "${aws_security_group.hexlet-basics-http.id}"
  security_group_id = "${aws_security_group.hexlet-basics-db.id}"
}

resource "aws_security_group_rule" "allow-tcp-db-port" {
  type            = "ingress"
  from_port       = 5432
  to_port         = 5432
  protocol        = "tcp"
  source_security_group_id = "${aws_security_group.hexlet-basics-http.id}"
  security_group_id = "${aws_security_group.hexlet-basics-db.id}"
}
