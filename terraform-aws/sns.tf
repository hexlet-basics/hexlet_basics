resource "aws_sns_topic" "codebuild" {
  name = "hexlet-basics-codebuild"
}

# resource "aws_sns_topic_subscription" "codebuild" {
#   topic_arn = "${aws_sns_topic.codebuild.arn}"
#   protocol  = "email"
#   endpoint  = "email"
# }
