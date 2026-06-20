# Get the latest Amazon Linux 2023 AMI

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Network Module

module "network" {
  source = "./modules/network"

  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = var.availability_zone

  project_name = var.project_name
  environment  = var.environment
}

# Storage Module

module "storage" {
  source = "./modules/storage"

  bucket_name = var.bucket_name

  project_name = var.project_name
  environment  = var.environment
}

# Compute Module

module "compute" {
  source = "./modules/compute"

  vpc_id    = module.network.vpc_id
  subnet_id = module.network.public_subnet_id

  ami_id        = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  project_name = var.project_name
  environment  = var.environment
}
