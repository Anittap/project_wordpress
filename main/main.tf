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
module "wp-igw" {
  source              = "../modules/igw"
  vpc_id              = module.wp_vpc.vpc_id
  project_environment = var.project_environment
  project_name        = var.project_name
}
module "db-igw" {
  source              = "../modules/igw"
  vpc_id              = module.db_vpc.vpc_id
  project_environment = var.project_environment
  project_name        = var.project_name
}
module "wp_rt" {
  source                    = "../modules/rt"
  project_environment       = var.project_environment
  project_name              = var.project_name
  vpc_id                    = module.wp_vpc.vpc_id
  type                      = "public"
  subnet_id                 = module.wp_vpc.public_subnet_ids
  vpc_peering_connection_id = module.peering_connection.id
  peer_cidr_block           = var.db_cidr_block
  internet_gateway_id       = module.wp-igw.igw_id
  enable_peering            = true
  enable_internet           = true
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
  internet_gateway_id       = module.db-igw.igw_id
  enable_peering            = true
  enable_internet           = false
}