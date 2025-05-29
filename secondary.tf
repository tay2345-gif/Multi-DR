provider "aws" {
  alias  = "secondary"
  region = "us-west-2"
}

module "vpc_secondary" {
  source               = "./modules/vpc"
  name_prefix          = "secondary"
  vpc_cidr             = "10.1.0.0/16"
  public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
  private_subnet_cidrs = ["10.1.3.0/24"]
  azs                  = ["us-west-2a", "us-west-2b"]
}

module "ec2_secondary" {
  source        = "./modules/ec2"
  name_prefix   = "secondary"
  ami_id        = "ami-0e472ba40eb589f49" # Replace with the latest AMI for your region
  instance_type = "t2.micro"
  subnet_id     = module.vpc_secondary.public_subnet_ids[0]
  vpc_id        = module.vpc_secondary.vpc_id
  key_name      = "your-key-name"
}
module "rds_secondary" {
  source           = "./modules/rds"
  name_prefix      = "secondary"
  db_name          = "prodapp"
  db_engine        = "mysql"
  instance_class   = "db.t3.micro"
  subnet_ids       = module.vpc_secondary.private_subnet_ids
  vpc_security_ids = [module.vpc_secondary.db_sg_id]
  multi_az         = false  # Can be true if needed
  restore_from_snapshot = true # Optional: custom flag if module supports snapshot restore
}

module "s3_secondary" {
  source      = "./modules/s3"
  name_prefix = "secondary"
  region      = "us-west-2"
  replication_arn = "arn:aws:s3:::primary-region-bucket"
}
