/* resource "aws_db_subnet_group" "hexlet-basics" { */
/*   name       = "hexlet-basics" */
/*   subnet_ids = ["${aws_subnet.hexlet-basics-db-a.id}", "${aws_subnet.hexlet-basics-db-b.id}"] */

/*   tags { */
/*     Name = "hexlet-basics" */
/*   } */
/* } */

resource "aws_db_subnet_group" "hexlet-basics" {
  name       = "main"
  subnet_ids = ["${aws_subnet.hexlet-basics-app-a.id}", "${aws_subnet.hexlet-basics-app-b.id}"]

  tags {
    Name = "hexlet-basics"
    Project = "hexlet-basics"
  }
}

resource "aws_db_instance" "hexlet-basics" {
  allocated_storage    = 10
  # storage_type         = "gp2"
  engine               = "postgres"
  availability_zone = "eu-central-1a"
  # engine_version       = "5.6.17"
  instance_class       = "db.t2.micro"
  name                 = "${var.db_name}"
  username             = "${var.db_username}"
  password             = "${var.db_password}"
  final_snapshot_identifier = "hexlet-basics"
  db_subnet_group_name = "${aws_db_subnet_group.hexlet-basics.id}"
  vpc_security_group_ids = [
    "${aws_security_group.hexlet-basics-db.id}"
  ]
  /* db_subnet_group_name = "${aws_db_subnet_group.hexlet-basics.id}" */
  # parameter_group_name = "default.mysql5.6"
}
