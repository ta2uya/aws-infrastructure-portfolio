module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  environment  = var.environment

  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
  availability_zones   = ["ap-northeast-1a", "ap-northeast-1c"]
}

module "vpc_endpoints" {
  source = "../../modules/vpc_endpoints"

  project_name    = var.project_name
  environment     = var.environment
  vpc_id          = module.vpc.vpc_id
  vpc_cidr        = module.vpc.vpc_cidr
  subnet_ids      = module.vpc.private_subnet_ids
  route_table_ids = [module.vpc.private_route_table_id]
  aws_region      = var.aws_region
}

module "security_group" {
  source = "../../modules/security_group"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
}

module "ec2" {
  source = "../../modules/ec2"

  project_name      = var.project_name
  environment       = var.environment
  instance_type     = "t3.micro"
  instance_count    = 2
  subnet_ids        = module.vpc.private_subnet_ids
  security_group_id = module.security_group.ec2_security_group_id
}

module "alb" {
  source = "../../modules/alb"

  project_name        = var.project_name
  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.vpc.public_subnet_ids
  security_group_id   = module.security_group.alb_security_group_id
  target_instance_ids = module.ec2.instance_ids
}