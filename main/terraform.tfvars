project_name                 = "redux-project"
project_environment          = "development"
region                       = "us-west-2"
owner                        = "Anitta"
bits                         = 4
wp_cidr_block                = "10.0.0.0/16"
db_cidr_block                = "10.1.0.0/16"
lb_sg_ports                  = ["80", "443","22"]
wp_sg_ports                  = ["80", "443"]
db_sg_ports                  = ["3306"]
domain_name                  = "anitta.redux.cloud"
lb_ingress_cidr_ipv4         = "0.0.0.0/0"
lb_egress_cidr_ipv4          = "0.0.0.0/0"
lb_egress_port               = "-1"
wp_egress_cidr_ipv4          = "0.0.0.0/0"
wp_egress_port               = "-1"
db_egress_cidr_ipv4          = "0.0.0.0/0"
db_egress_port               = "-1"
wp_max_size                  = 5
wp_min_size                  = 1
wp_desired_size              = 3
wp_health_check_grace_period = 300
wp_enable_elb_health_checks  = { "production" = true, "development" = false }
instance_type = {
  "production"  = "t4g.medium",
  "development" = "t4g.small"
}