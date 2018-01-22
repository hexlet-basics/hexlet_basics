resource "aws_cloudwatch_log_group" "hexlet_basics" {
  name = "hexlet_basics"

  # tags {
  #   Environment = "production"
  #   Application = "serviceA"
  # }
}

resource "aws_cloudwatch_log_stream" "web" {
  name           = "web"
  log_group_name = "${aws_cloudwatch_log_group.hexlet_basics.name}"
}
