resource "aws_route53_zone" "hexlet-basics-ru" {
  name = "code-basics.ru."
}

resource "aws_route53_record" "hexlet-basics-ru-ns" {
  zone_id = "${aws_route53_zone.hexlet-basics-ru.zone_id}"
  name    = "code-basics.ru"
  type    = "NS"
  ttl     = "30"

  records = [
    "${aws_route53_zone.hexlet-basics-ru.name_servers.0}",
    "${aws_route53_zone.hexlet-basics-ru.name_servers.1}",
    "${aws_route53_zone.hexlet-basics-ru.name_servers.2}",
    "${aws_route53_zone.hexlet-basics-ru.name_servers.3}",
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
    "${aws_route53_zone.hexlet-basics-en.name_servers.0}",
    "${aws_route53_zone.hexlet-basics-en.name_servers.1}",
    "${aws_route53_zone.hexlet-basics-en.name_servers.2}",
    "${aws_route53_zone.hexlet-basics-en.name_servers.3}",
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
