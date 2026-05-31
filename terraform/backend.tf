terraform {
  backend "s3" {
    bucket         = "project-bedrock-tfstate-494378024852"
    key            = "karatu2025/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "project-bedrock-tflock"
    encrypt        = true
  }
}
