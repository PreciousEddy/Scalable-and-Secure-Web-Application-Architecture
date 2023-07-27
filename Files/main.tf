provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "web_app" {
  name = "web_app"
  description = "Allow inbound HTTP traffic"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "web_app" {
  key_name = "web_app"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "web_app" {
  ami = "ami-0d338907e13fb5520"
  instance_type = "t2.micro"
  key_name = aws_key_pair.web_app.key_name
  security_groups = [aws_security_group.web_app.id]

  tags {
    Name = "web_app"
  }
}

resource "aws_load_balancer" "web_app" {
  name = "web_app"
  load_balancer_type = "application"

  subnets = [
    "subnet-0011223344556677",
    "subnet-8899aabbccddeeff",
  ]

  security_groups = [aws_security_group.web_app.id]
}

resource "aws_lb_target_group" "web_app" {
  name = "web_app"
  port = 80
  protocol = "HTTP"
  target_type = "instance"

  health_check {
    interval = 10
    unhealthy_threshold = 2
    healthy_threshold = 3
    timeout = 3
    path = "/"
  }

  instances = [aws_instance.web_app.id]
}

resource "aws_lb_listener" "web_app" {
  load_balancer_arn = aws_load_balancer.web_app.arn
  port = 80
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.web_app.arn
  }
}

resource "aws_rds_instance" "web_app" {
  instance_class = "db.t2.micro"
  allocated_storage = 5
  engine = "mysql"
  engine_version = "5.7.21"
  name = "web_app"
  username = "admin"
  password = "password"
  vpc_security_group_ids = [aws_security_group.web_app.id]
  db_subnet_group_name = "default"

  tags {
    Name = "web_app"
  }
}
