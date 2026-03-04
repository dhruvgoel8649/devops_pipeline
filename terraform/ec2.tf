resource "aws_instance" "app_server" {
  ami           = "ami-051a31ab2f4d498f5"
  instance_type = "t2.micro"

  security_groups = [aws_security_group.app_sg.name]

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  user_data = file("install_docker.sh")

  tags = {
    Name = "DevOps-App-Server"
  }
}
