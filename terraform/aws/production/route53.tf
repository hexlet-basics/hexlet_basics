resource "aws_route53_zone" "hexlet-basics-ru" {
  name = "code-basics.ru."
}

resource "aws_route53_record" "hexlet-basics-ru-ns" {
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

resource "aws_route53_record" "hexlet-basics-ru-a" {
  zone_id = "${aws_route53_zone.hexlet-basics-ru.zone_id}"
  name    = "code-basics.ru"
  type    = "A"

  alias {
    name                   = "${aws_lb.hexlet-basics.dns_name}"
    zone_id                = "${aws_lb.hexlet-basics.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_zone" "hexlet-basics-en" {
  name = "code-basics.com."
}

resource "aws_route53_record" "hexlet-basics-en-ns" {
  zone_id = "${aws_route53_zone.hexlet-basics-en.zone_id}"
  name    = "code-basics.com"
  type    = "NS"
  ttl     = "30"

  records = [
    "ns-491.awsdns-61.com.",
    "ns-946.awsdns-54.net.",
    "ns-1773.awsdns-29.co.uk.",
    "ns-1431.awsdns-50.org."
  ]
}

resource "aws_route53_record" "hexlet-basics-en-a" {
  zone_id = "${aws_route53_zone.hexlet-basics-en.zone_id}"
  name    = "code-basics.com"
  type    = "A"

  alias {
    name                   = "${aws_lb.hexlet-basics.dns_name}"
    zone_id                = "${aws_lb.hexlet-basics.zone_id}"
    evaluate_target_health = true
  }
}
