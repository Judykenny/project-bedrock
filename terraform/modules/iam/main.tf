resource "aws_iam_user" "dev_view" {
  name = "bedrock-dev-view"
  tags = { Name = "bedrock-dev-view" }
}

resource "aws_iam_user_policy_attachment" "readonly" {
  user       = aws_iam_user.dev_view.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_policy" "s3_put" {
  name = "project-bedrock-s3-put"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["s3:PutObject"]
      Resource = "${var.assets_bucket_arn}/*"
    }]
  })
}

resource "aws_iam_user_policy_attachment" "s3_put" {
  user       = aws_iam_user.dev_view.name
  policy_arn = aws_iam_policy.s3_put.arn
}

resource "aws_iam_access_key" "dev_view" {
  user = aws_iam_user.dev_view.name
}
