resource "aws_route53_record" "cms_app_route53" {
  zone_id = var.zone_id
  name    = "cms-app-${var.environment}.techrite.org"
  type    = "A"
  alias {
    name                   = aws_lb.cms_app_lb.dns_name
    zone_id                = aws_lb.cms_app_lb.zone_id
    evaluate_target_health = true
  }
  
}