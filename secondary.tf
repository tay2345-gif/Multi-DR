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
  ami_id        = "ami-0e472ba40eb589f49"  # Replace with the latest AMI for your region
  instance_type = "t2.micro"
  subnet_id     = module.vpc_secondary.public_subnet_ids[0]
  vpc_id        = module.vpc_secondary.vpc_id
  key_name      = "your-key-name"
}