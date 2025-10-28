provider "aws" {
    region = "us-east-2"
}

resource "aws_sns_topic" "budget_alerts" {
  name = "aws-budget-alerts"
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.budget_alerts.arn
  protocol  = "email"
  endpoint  = "malik92001@gmail.com"
}

resource "aws_budgets_budget" "monthly_budget" {
  name              = "Monthly-Budget-1USD"
  budget_type       = "COST"
  limit_amount      = "1"
  limit_unit        = "USD"
  time_period_start = "2017-07-01_00:00"
  time_unit         = "MONTHLY"
  cost_types {
    include_credit             = false
    include_discount           = false
    include_other_subscription = false
    include_recurring          = false
    include_refund             = false
    include_subscription       = true
    include_support            = false
    include_tax                = false
    include_upfront            = false
    use_blended                = false
  }
  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_sns_topic_arns = [aws_sns_topic.budget_alerts.arn]
  }
}