resource "aws_sns_topic" "my_topic" {
  name = "EC2StateChangeTopic"
}

resource "aws_sns_topic_subscription" "my_subscription" {
  topic_arn = aws_sns_topic.my_topic.arn
  protocol  = "email"
  endpoint  = "danibarko42@gmail.com"
}

resource "aws_cloudwatch_event_target" "sns_target" {
  rule      = aws_cloudwatch_event_rule.my_event_rule.name
  target_id = "EC2StateChangeAlert"
  arn       = aws_sns_topic.my_topic.arn
}
