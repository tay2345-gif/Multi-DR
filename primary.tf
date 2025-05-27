provider "aws" {
  region = "us-east-1"
}



module "vpc_primary" {
  source               = "./modules/vpc"
  name_prefix          = "primary"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24"]
  private_subnet_cidrs = ["10.0.2.0/24"]
  azs                  = ["us-east-1a"]
}

module "ec2_primary" {
  source        = "./modules/ec2"
  name_prefix   = "primary"
  ami_id        = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnet_ids[0]
  vpc_id        = module.vpc.vpc_id
  key_name      = "your-key-name"
}

module "rds" {
  source           = "./modules/rds"
  db_name          = "prodapp"
  db_engine        = "mysql"
  instance_class   = "db.t3.micro"
  subnet_ids       = module.vpc.private_subnet_ids
  vpc_security_ids = [module.vpc.db_sg_id]
  multi_az         = true
}

module "s3" {
  source          = "./modules/s3"
  name_prefix     = "primary"
  region          = "us-east-1"
  replication_arn = "arn:aws:s3:::secondary-region-bucket"
}

module "route53" {
  source = "./modules/route"

  zone_id      = "123456789ABCDEFG"
  record_name  = "app.example.com"
  primary_ip   = module.ec2_primary.public_ip
  secondary_ip = module.ec2_secondary.public_ip
}
