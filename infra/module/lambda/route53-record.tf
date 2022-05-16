resource "aws_api_gateway_domain_name" "default" {
  count = var.route53_record ? 1 : 0

  domain_name              = "${var.name}.${var.route53_zone_name}"
  regional_certificate_arn = data.aws_acm_certificate.default[count.index].arn
  endpoint_configuration {
    types = [var.endpoint_type]
  }
}

resource "aws_api_gateway_base_path_mapping" "default" {
  count = var.route53_record ? 1 : 0

  api_id      = aws_api_gateway_rest_api.default[count.index].id
  domain_name = aws_api_gateway_domain_name.default[count.index].domain_name
  stage_name  = aws_api_gateway_deployment.default[count.index].stage_name
}

resource "aws_route53_record" "default" {
  count = var.route53_record ? 1 : 0

  name    = aws_api_gateway_domain_name.default[count.index].domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.default[count.index].id

  alias {
    evaluate_target_health = false
    name                   = aws_api_gateway_domain_name.default[count.index].regional_domain_name
    zone_id                = aws_api_gateway_domain_name.default[count.index].regional_zone_id
  }
}

data "aws_route53_zone" "default" {
  count = var.route53_record ? 1 : 0

  name         = var.route53_zone_name
  private_zone = var.r53_is_private_zone

}

data "aws_acm_certificate" "default" {
  count = var.route53_record ? 1 : 0

  domain      = "*.${var.route53_zone_name}"
  statuses    = ["ISSUED"]
  most_recent = true
}