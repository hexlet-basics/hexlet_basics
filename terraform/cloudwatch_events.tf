resource "aws_cloudwatch_event_rule" "codebuild" {
  name        = "hexlet-basics-codebuild"
  # description = ""

  event_pattern = <<PATTERN
{
  "source": [
    "aws.codepipeline"
  ],
  "detail-type": [
    "Hexlet Basics Codebuild Status"
  ]
}
PATTERN
}

resource "aws_cloudwatch_event_target" "sns_to_slack_operation" {
  rule      = "${aws_cloudwatch_event_rule.codebuild.name}"
  target_id = "sns-to-slack-id"
  arn       = "${aws_sns_topic.codebuild.arn}"
}
