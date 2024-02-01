resource "aws_instance" "apache" {
  ami                    = "ami-0a3c3a20c09d6f377"
  instance_type          = "t2.medium"
  key_name               = "ec2-key"
  vpc_security_group_ids = [aws_security_group.ssh_security_group.id]
  subnet_id              = aws_subnet.public_subnet_AZ1.id
  for_each               = toset(["master", "slave", "ansible"])
  tags = {
    Name = "${each.key}"
  }
}