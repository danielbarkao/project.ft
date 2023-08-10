resource "aws_cloudwatch_event_rule" "my_event_rule" {
  name        = "EC2PowerScheduleRule"
  description = "Turn on and off EC2 instance daily"

  schedule_expression = "cron(0 7,19 * * ? *)"  # Run at 7am and 7pm UTC

  event_pattern = <<PATTERN
{
  "source": ["aws.ec2"],
  "detail-type": ["EC2 Instance State-change Notification"],
  "detail": {
    "state": ["stopped", "running"]
  }
}
PATTERN
}

resource "aws_lambda_function" "my_lambda_function" {
  filename      = "python.zip"
  function_name = "my_lambda_function"
  role          = aws_iam_role.my_lambda_role.arn
  handler       = "index.handler"
  runtime       = "python3.8"
}

resource "aws_cloudwatch_event_target" "start_ec2_target" {
  rule      = aws_cloudwatch_event_rule.my_event_rule.name
  target_id = "StartEC2Instance"
  arn       = aws_lambda_function.my_lambda_function.arn

  input = <<JSON
{
  "status": "start"
}
JSON
}

resource "aws_cloudwatch_event_target" "stop_ec2_target" {
  rule      = aws_cloudwatch_event_rule.my_event_rule.name
  target_id = "StopEC2Instance"
  arn       = aws_lambda_function.my_lambda_function.arn

  input = <<JSON
{
  "status": "stop"
}
JSON
}
resource "aws_iam_role" "my_lambda_role" {
  name = "my_lambda_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "my_lambda_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.my_lambda_role.name
}
