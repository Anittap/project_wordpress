module "wp_vpc" {
  source              = "../modules/vpc"
  cidr_block          = var.wp_cidr_block
  project_name        = "${var.project_name}-wp"
  project_environment = var.project_environment
  region              = var.region
  owner               = var.owner
  bits                = var.bits
}
module "db_vpc" {
  source              = "../modules/vpc"
  cidr_block          = var.db_cidr_block
  project_name        = "${var.project_name}-db"
  project_environment = var.project_environment
  region              = var.region
  owner               = var.owner
  bits                = var.bits
}

module "peering_connection" {
  source              = "../modules/peering_connection"
  project_environment = var.project_environment
  project_name        = var.project_name
  accepter_id         = module.db_vpc.vpc_id
  requester_id        = module.wp_vpc.vpc_id
}
module "lb-igw" {
  source              = "../modules/igw"
  vpc_id              = module.wp_vpc.vpc_id
  project_environment = var.project_environment
  project_name        = var.project_name
}
module "lb_rt" {
  source                    = "../modules/rt"
  project_environment       = var.project_environment
  project_name              = var.project_name
  vpc_id                    = module.wp_vpc.vpc_id
  type                      = "public"
  subnet_id                 = module.wp_vpc.public_subnet_ids
  vpc_peering_connection_id = null
  peer_cidr_block           = null
  internet_gateway_id       = module.lb-igw.igw_id
  enable_peering            = false
  enable_internet           = true
}
module "wp_rt" {
  source                    = "../modules/rt"
  project_environment       = var.project_environment
  project_name              = var.project_name
  vpc_id                    = module.wp_vpc.vpc_id
  type                      = "private"
  subnet_id                 = module.wp_vpc.private_subnet_ids
  vpc_peering_connection_id = module.peering_connection.id
  peer_cidr_block           = var.db_cidr_block
  internet_gateway_id       = null
  enable_peering            = true
  enable_internet           = false
}

module "db_rt" {
  source                    = "../modules/rt"
  project_environment       = var.project_environment
  project_name              = var.project_name
  vpc_id                    = module.db_vpc.vpc_id
  type                      = "private"
  subnet_id                 = module.db_vpc.private_subnet_ids
  vpc_peering_connection_id = module.peering_connection.id
  peer_cidr_block           = var.wp_cidr_block
  internet_gateway_id       = null
  enable_peering            = true
  enable_internet           = false
}
module "ssl" {
  source      = "../modules/acm"
  domain_name = data.aws_route53_zone.main.name
  zone_id     = data.aws_route53_zone.main.zone_id
}
module "key_pair" {
  source              = "../modules/key-pair"
  key_file            = file("../mykey.pub")
  project_name        = var.project_name
  project_environment = var.project_environment
}
module "lb_sg" {
  source              = "../modules/sg/default_sg"
  project_name        = var.project_name
  project_environment = var.project_environment
  name                = "lb"
  description         = "Load balancer security group"
  vpc_id              = module.wp_vpc.vpc_id
  sg_ports            = var.lb_sg_ports
  ingress_cidr_ipv4   = var.lb_ingress_cidr_ipv4
  egress_cidr_ipv4    = var.lb_egress_cidr_ipv4
  egress_port         = var.lb_egress_port
}
module "wp_sg" {
  source              = "../modules/sg/sg_reference_sg"
  project_name        = var.project_name
  project_environment = var.project_environment
  name                = "wp"
  description         = "wp security group"
  vpc_id              = module.wp_vpc.vpc_id
  sg_ports            = var.wp_sg_ports
  sg_reference_id     = module.lb_sg.id
  egress_cidr_ipv4    = var.wp_egress_cidr_ipv4
  egress_port         = var.wp_egress_port
}
module "db_sg" {
  source              = "../modules/sg/sg_reference_sg"
  project_name        = var.project_name
  project_environment = var.project_environment
  name                = "db"
  description         = "db security group"
  vpc_id              = module.db_vpc.vpc_id
  sg_ports            = var.db_sg_ports
  egress_cidr_ipv4    = var.db_egress_cidr_ipv4
  egress_port         = var.db_egress_port
  sg_reference_id     = module.wp_sg.id

}
module "wp_lt" {
  source              = "../modules/lt"
  project_name        = var.project_name
  project_environment = var.project_environment
  name                = "wp"
  ami_id              = data.aws_ami.packer_ami.id
  key_pair            = module.key_pair.key_name
  sg_id               = module.wp_sg.id
}
//lt > asg > tg > alb > rds > bastion >ansible > nacl > 