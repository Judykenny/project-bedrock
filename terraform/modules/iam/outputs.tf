output "dev_view_access_key_id" {
  value = aws_iam_access_key.dev_view.id
}

output "dev_view_secret_access_key" {
  value     = aws_iam_access_key.dev_view.secret
  sensitive = true
}
