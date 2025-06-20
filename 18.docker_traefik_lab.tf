#Use this when using Docker Traefik Lab.
resource "aws_lb" "network" {
    name               = "traefik-lab"
    load_balancer_type = "network"
    subnets            = aws_subnet.public-subnets.*.id
}

resource "aws_lb_target_group" "tcp" {
    name     = "tcp-target-group"
    port     = 80
    protocol = "TCP"
    vpc_id   = aws_vpc.default.id
}

resource "aws_lb_target_group" "tls" {
    name     = "tls-target-group"
    port     = 443
    protocol = "TCP"
    vpc_id   = aws_vpc.default.id
}

resource "aws_lb_listener" "tcp" {
    load_balancer_arn = aws_lb.network.arn
    port              = 80
    protocol          = "TCP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.tcp.arn
    }
}

resource "aws_lb_listener" "tls" {
    load_balancer_arn = aws_lb.network.arn
    port              = 443
    protocol          = "TCP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.tls.arn
    }
}


resource "aws_lb_target_group_attachment" "tcp80" {
    count = 6
    target_group_arn = aws_lb_target_group.tcp.arn
    target_id        = element(aws_instance.webservers.*.id, count.index)
}

resource "aws_lb_target_group_attachment" "tls443" {
    count = 6
    target_group_arn = aws_lb_target_group.tls.arn
    target_id        = element(aws_instance.webservers.*.id, count.index)
}

#If no existing domain name, use this to create a new one.
# resource "aws_route53_zone" "example" {
#     name = "hello.xyz"
# }


data "aws_route53_zone" "zone" {
    name = "chodagams.shop" #Change this to your domain name as yours.
}

resource "aws_route53_record" "traefik" {
    zone_id = data.aws_route53_zone.zone.zone_id
    name    = "traefik.chodagams.shop"
    type    = "CNAME"
    ttl     = 300
    records = [aws_lb.network.dns_name]
}

resource "aws_route53_record" "www" {
    zone_id = data.aws_route53_zone.zone.zone_id
    name    = "www.chodagams.shop"
    type    = "CNAME"
    ttl     = 300
    records = [aws_lb.network.dns_name]
}

resource "aws_route53_record" "vote" {
    zone_id = data.aws_route53_zone.zone.zone_id
    name    = "vote.chodagams.shop"
    type    = "CNAME"
    ttl     = 300
    records = [aws_lb.network.dns_name]
}

resource "aws_route53_record" "result" {
    zone_id = data.aws_route53_zone.zone.zone_id
    name    = "result.chodagams.shop"
    type    = "CNAME"
    ttl     = 300
    records = [aws_lb.network.dns_name]
}

resource "aws_route53_record" "fastapi" {
    zone_id = data.aws_route53_zone.zone.zone_id
    name    = "fastapi.chodagams.shop"
    type    = "CNAME"
    ttl     = 300
    records = [aws_lb.network.dns_name]
}

resource "aws_route53_record" "nginx" {
    zone_id = data.aws_route53_zone.zone.zone_id
    name    = "nginx.chodagams.shop"
    type    = "CNAME"
    ttl     = 300
    records = [aws_lb.network.dns_name]
}












