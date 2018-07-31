resource "aws_iam_role" "webserver" {
  name = "webserver"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "logs" {
    name        = "logs"
    # description = "A test policy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Action": [
              "logs:CreateLogGroup",
              "logs:CreateLogStream",
              "logs:DescribeLogGroups",
              "logs:DescribeLogStreams",
              "logs:PutLogEvents",
              "logs:GetLogEvents",
              "logs:FilterLogEvents"
          ],
          "Effect": "Allow",
          "Resource": "*"
      }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "logs_to_webservers" {
    role       = "${aws_iam_role.webserver.name}"
    policy_arn = "${aws_iam_policy.logs.arn}"
  }

resource "aws_iam_instance_profile" "webserver" {
  name  = "webserver"
  role = "${aws_iam_role.webserver.name}"
}
