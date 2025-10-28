output "budget_name" {
  value = aws_budgets_budget.monthly_budget.name
}

output "sns_topic_arn" {
  value = aws_sns_topic.budget_alerts.arn
}