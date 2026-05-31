module "vpc" {
  source       = "./modules/vpc"
  cluster_name = var.cluster_name
  vpc_name     = var.vpc_name
}

module "eks" {
  source       = "./modules/eks"
  cluster_name = var.cluster_name
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnet_ids
}

module "rds" {
  source             = "./modules/rds"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  db_password        = var.db_password
}

module "dynamodb" {
  source = "./modules/dynamodb"
}

module "s3" {
  source     = "./modules/s3"
  student_id = var.student_id
}

module "lambda" {
  source             = "./modules/lambda"
  assets_bucket_name = module.s3.assets_bucket_name
  assets_bucket_arn  = module.s3.assets_bucket_arn
}

module "iam" {
  source            = "./modules/iam"
  assets_bucket_arn = module.s3.assets_bucket_arn
  cluster_name      = var.cluster_name
}
