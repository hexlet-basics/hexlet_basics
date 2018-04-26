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

resource "aws_route53_record" "hexlet-basics-ru-txt-google-site-verification" {
  zone_id = "${aws_route53_zone.hexlet-basics-ru.zone_id}"
  name    = "code-basics.ru"
  type    = "TXT"
  ttl     = "30"

  records = [
    "google-site-verification=4huglkhRsZ-R-K7j_xxxkfVgqaJq-Ir1fwnN05RV50o",
  ]
}

resource "aws_route53_record" "hexlet-basics-ru-a" {
  zone_id = "${aws_route53_zone.hexlet-basics-ru.zone_id}"
  name    = "code-basics.ru"
  type    = "A"
	set_identifier = "live"
	failover_routing_policy {
		type = "PRIMARY"
	}
  health_check_id = "${aws_route53_health_check.code-basics-ru.id}"

  alias {
    name                   = "${aws_lb.hexlet-basics.dns_name}"
    zone_id                = "${aws_lb.hexlet-basics.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "code-basics-ru-static-site" {
	zone_id = "${aws_route53_zone.hexlet-basics-ru.zone_id}"
	name = "code-basics.ru"
	set_identifier = "static"
	type = "A"
	alias {
		name = "${aws_s3_bucket.hexlet-basics-static-site.website_domain}"
		zone_id = "${aws_s3_bucket.hexlet-basics-static-site.hosted_zone_id}"
		evaluate_target_health = false
	}
	failover_routing_policy {
		type = "SECONDARY"
	}
}

resource "aws_route53_health_check" "code-basics-ru" {
  fqdn = "code-basics.ru"
  port = "80"
  type = "HTTP"
  resource_path = "/"
  failure_threshold = "3"
  request_interval = "30"

  tags = {
    Name = "code-basics.ru health check"
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

resource "aws_route53_record" "hexlet-basics-en-txt-google-site-verification" {
  zone_id = "${aws_route53_zone.hexlet-basics-en.zone_id}"
  name    = "code-basics.com"
  type    = "TXT"
  ttl     = "30"

  records = [
    "google-site-verification=0kk3DdOciLvoog-nVFcbRzmZH65FWmNW-_aYElP0gJk",
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
