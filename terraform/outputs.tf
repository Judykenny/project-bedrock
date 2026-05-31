output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_name" {
  value = var.cluster_name
}

output "region" {
  value = var.aws_region
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "assets_bucket_name" {
  value = module.s3.assets_bucket_name
}

output "dev_view_access_key_id" {
  value = module.iam.dev_view_access_key_id
}

output "dev_view_secret_access_key" {
  value     = module.iam.dev_view_secret_access_key
  sensitive = true
}
