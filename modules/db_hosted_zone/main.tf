resource "aws_route53_record" "rds_record" {
  zone_id = var.zone_id
  name    = var.rds_record_name
  type    = "CNAME"
  ttl     = 300
  records = [var.rds_endpoint]
}