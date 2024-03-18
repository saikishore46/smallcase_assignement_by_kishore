resource "aws_instance" "ec2_instance" {
  ami           = "ami-05a5bb48beb785bf1"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name      = "terrafrom"
  tags = {
    Name = "assignment_instance"
  }
}

data "aws_ami" "latest" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_ebs_volume" "encrypted_volume" {
  availability_zone = aws_instance.ec2_instance.availability_zone
  size              = 10
  encrypted         = true
}

resource "aws_volume_attachment" "ebs_attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.encrypted_volume.id
  instance_id = aws_instance.ec2_instance.id
}

output "public_ip" {
  value = aws_instance.ec2_instance.public_ip
}
