provider "aws" {
	version = "~> 1.5"
	region = "eu-central-1"
}

resource "aws_vpc" "hexlet-basics" {
	cidr_block = "172.16.0.0/24"
	# instance_tenancy = "dedicated"

	tags {
		Name = "hexlet-basics"
	}
}

resource "aws_subnet" "hexlet-basics-app-a" {
	vpc_id = "${aws_vpc.hexlet-basics.id}"
	cidr_block = "172.16.0.0/27"
	availability_zone = "eu-central-1a"

	tags {
		Name = "hexlet-basics-app-a"
	}
}

resource "aws_subnet" "hexlet-basics-app-b" {
	vpc_id = "${aws_vpc.hexlet-basics.id}"
	cidr_block = "172.16.0.32/27"
	availability_zone = "eu-central-1b"

	tags {
		Name = "hexlet-basics-app-b"
	}
}

resource "aws_subnet" "hexlet-basics-db-a" {
	vpc_id = "${aws_vpc.hexlet-basics.id}"
	cidr_block = "172.16.0.65/27"

	tags {
		Name = "hexlet-basics-db-a"
	}
}

resource "aws_subnet" "hexlet-basics-db-b" {
	vpc_id = "${aws_vpc.hexlet-basics.id}"
	cidr_block = "172.16.0.98/27"

	tags {
		Name = "hexlet-basics-db-b"
	}
}

resource "aws_instance" "hexlet-basics-web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.hexlet-basics-app-a.id}"

  tags {
    Name = "hexlet-basics-web-a"
  }
}
