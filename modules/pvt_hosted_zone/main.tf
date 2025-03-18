resource "aws_route53_zone" "private_zone" {
  name = var.private_zone_name
  vpc {
    vpc_id = var.vpc_id
  }
  comment = "Private hosted zone for internal use"
}
resource "aws_route53_record" "rds_record" {
  zone_id = aws_route53_zone.private_zone.zone_id
  name    = var.rds_record_name
  type    = "CNAME"
  ttl     = 300
  records = [var.rds_endpoint]
}