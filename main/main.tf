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
module "wp_nat_gateway" {
  source              = "../modules/natgw"
  project_name        = var.project_name
  project_environment = var.project_environment
  public_subnet_id    = module.wp_vpc.public_subnet_ids[1]
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
  enable_nat_gateway        = false
  nat_gateway_id            = null
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
  enable_nat_gateway        = true
  nat_gateway_id            = module.wp_nat_gateway.id
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
  enable_nat_gateway        = false
  nat_gateway_id            = null
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
  instance_type       = var.instance_type

}
module "wp_asg" {
  source                    = "../modules/asg"
  project_name              = var.project_name
  project_environment       = var.project_environment
  name                      = "wp"
  max_size                  = var.wp_max_size
  min_size                  = var.wp_min_size
  desired_size              = var.wp_desired_size
  health_check_grace_period = var.wp_health_check_grace_period
  enable_elb_health_checks  = var.wp_enable_elb_health_checks
  private_subnets           = module.wp_vpc.private_subnet_ids
  lt_id                     = module.wp_lt.id
  lt_version                = module.wp_lt.version
}

module "db_instance" {
  source            = "../modules/rds"
  project_name      = var.project_name
  db_name           = jsondecode(data.aws_secretsmanager_secret_version.db_credentials.secret_string)["database"]
  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type
  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  db_username       = jsondecode(data.aws_secretsmanager_secret_version.db_credentials.secret_string)["username"]
  db_password       = jsondecode(data.aws_secretsmanager_secret_version.db_credentials.secret_string)["password"]
  subnet_ids        = module.db_vpc.private_subnet_ids
  sg_id             = module.db_sg.id
}
module "dns" {
  source          = "../modules/route53"
  zone_id         = data.aws_route53_zone.main.id
  rds_record_name = "db"
  rds_endpoint    = module.db_instance.address
  project_name    = var.project_name
  domain_name     = data.aws_route53_zone.main.name
  lb_dns_name     = module.alb.dns_name
  lb_zone_id      = module.alb.zone_id

}
module "tg" {
  source                        = "../modules/tg"
  project_name                  = var.project_name
  project_environment           = var.project_environment
  name                          = "tg"
  load_balancing_algorithm_type = var.load_balancing_algorithm_type
  port                          = var.port
  protocol                      = var.protocol
  vpc_id                        = module.wp_vpc.vpc_id
  deregistration_delay          = var.deregistration_delay
  stickiness_type               = var.stickiness_type
  cookie_duration               = var.cookie_duration
  health_check_enabled          = var.health_check_enabled
  healthy_threshold             = var.healthy_threshold
  interval                      = var.interval
  path                          = var.path
  health_check_protocol         = var.health_check_protocol
  unhealthy_threshold           = var.unhealthy_threshold
  matcher                       = var.matcher
}
module "asg_to_tg_attachment" {
  source = "../modules/tg_to_asg_attatchment"
  tg_arn = module.tg.arn
  asg_id = module.wp_asg.id
}
module "alb" {
  source                     = "../modules/alb"
  project_name               = var.project_name
  project_environment        = var.project_environment
  name                       = "alb"
  lb_type                    = var.lb_type
  sg_id                      = module.lb_sg.id
  subnet_ids                 = module.wp_vpc.public_subnet_ids
  enable_deletion_protection = var.enable_deletion_protection
  https_listener_port        = var.https_listener_port
  certificate_arn            = module.ssl.arn
  tg_arn                     = module.tg.arn
  domain_name                = data.aws_route53_zone.main.name
  zone_id                    = data.aws_route53_zone.main.zone_id
  http_listener_port         = var.http_listener_port
  type                       = var.type
}
module "bastion_sg" {
  source              = "../modules/sg/default_sg"
  project_name        = var.project_name
  project_environment = var.project_environment
  name                = "bastion"
  description         = "Bastion security group"
  vpc_id              = module.wp_vpc.vpc_id
  sg_ports            = var.bastion_sg_ports
  ingress_cidr_ipv4   = var.bastion_ingress_cidr_ipv4
  egress_cidr_ipv4    = var.bastion_egress_cidr_ipv4
  egress_port         = var.bastion_egress_port
}
module "bastion" {
  source            = "../modules/bastion"
  ami               = var.ami
  instance_type     = "t2.small"
  key_name          = module.key_pair.key_name
  public_subnet_id  = module.wp_vpc.public_subnet_ids[0]
  security_group_id = module.bastion_sg.id
  project_name      = var.project_name
  project_environment = var.project_environment
}
module "bastion_to_wp" {
  source                   = "../modules/sg/bastion_sg"
  sg_ports                  = var.ssh_port
  sg_id        = module.wp_sg.id
  referenced_security_group_id = module.bastion_sg.id
}
// fix wp-admin error
// create nacl