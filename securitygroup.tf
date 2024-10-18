resource "aws_security_group" "kuzan_sg" {
  vpc_id = aws_vpc.kuzan_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # SSH access
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # HTTP access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }

  tags = {
    name = "devops-group-5"
  } 
}




resource "aws_instance" "kuzan_server" {
  ami                    = var.ami
  depends_on = [aws_security_group.kuzan_sg, aws_subnet.kuzan_subnet]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.kuzan_subnet.id    # Reference to your VPC's subnet
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.kuzan_sg.id]  # Reference to your Security Group
  user_data     = <<-EOF
        #!/bin/bash
        apt-get update
        apt-get install -y nginx
        systemctl start nginx
        systemctl enable nginx
    EOF

  tags = {
    name = "devops-group-5"
  }
}