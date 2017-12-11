resource "aws_route53_zone" "hexlet-basics-ru" {
  name = "code-basics.ru."
}

resource "aws_route53_record" "ns" {
  zone_id = "${aws_route53_zone.hexlet-basics-ru.zone_id}"
  name    = "code-basics.ru"
  type    = "NS"
  ttl     = "30"

  records = [
    "ns-167.awsdns-20.com.",
    "ns-524.awsdns-01.net.",
    "ns-1386.awsdns-45.org.",
    "ns-2000.awsdns-58.co.uk.",
  ]
}

resource "aws_route53_record" "www" {
  zone_id = "${aws_route53_zone.hexlet-basics-ru.zone_id}"
  name    = "code-basics.ru"
  type    = "A"

  alias {
    name                   = "${aws_lb.hexlet-basics.dns_name}"
    zone_id                = "${aws_lb.hexlet-basics.zone_id}"
    evaluate_target_health = true
  }
}

# resource "aws_route53_record" "www" {
#   zone_id = "${aws_route53_zone.primary.zone_id}"
#   name    = "www.example.com"
#   type    = "A"
#   ttl     = "300"
#   records = ["${aws_eip.lb.public_ip}"]
# }
