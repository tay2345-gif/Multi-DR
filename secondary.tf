provider "aws" {
  region = "us-west-2"  
}


module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr            = "10.1.0.0/16"
  public_subnet_cidrs = ["10.1.1.0/24", "10.1.2.0/24"]
  availability_zones  = ["us-west-2a", "us-west-2b"]
  environment         = "secondary"
}


module "ec2_secondary" {
  source = "../../modules/ec2"

  ami_id                 = "ami-0e472ba40eb589f49"  # Replace with latest Amazon Linux 2 AMI for this region
  instance_type          = "t2.micro"
  subnet_id              = module.vpc.public_subnet_ids[0]
  vpc_security_group_ids = [module.vpc.default_sg_id]
  key_name               = "your-key-name"  
  instance_name          = "secondary-web"
}
