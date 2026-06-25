# -----------------------------------------
# Get Latest Ubuntu 24.04 LTS AMI
# -----------------------------------------

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# -----------------------------------------
# Security Group
# -----------------------------------------

resource "aws_security_group" "web_sg" {

  name        = "assessment-web-sg"
  description = "Allow HTTP and SSH"

  ingress {
    description = "SSH"

    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"

    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "Assessment Security Group"
  }
}

# -----------------------------------------
# IAM Role
# -----------------------------------------

resource "aws_iam_role" "ec2_role" {

  name = "assessment-ec2-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "ec2.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })

}

resource "aws_iam_role_policy_attachment" "ssm_policy" {

  role       = aws_iam_role.ec2_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}

resource "aws_iam_instance_profile" "instance_profile" {

  name = "assessment-instance-profile"

  role = aws_iam_role.ec2_role.name

}

# -----------------------------------------
# EC2 Instance
# -----------------------------------------

resource "aws_instance" "web" {

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  key_name = var.key_name

  vpc_security_group_ids = [

    aws_security_group.web_sg.id

  ]

  iam_instance_profile = aws_iam_instance_profile.instance_profile.name

  user_data = file("${path.module}/userdata.sh")

  tags = {

    Name = "Assessment-Web-Server"

  }

}