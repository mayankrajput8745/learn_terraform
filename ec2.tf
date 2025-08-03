resource "aws_instance" "jenkins_master" {
  ami                    = "ami-0f58b397bc5c1f2e8" # Amazon Linux 2 (update with latest for ap-south-1)
  instance_type          = "t3.small"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  key_name               = "jenkins-master"

  tags = {
    Name = "Jenkins-master"
    Role = "master"
  }
}

resource "aws_instance" "jenkins_slave" {
  ami                    = "ami-0f58b397bc5c1f2e8"
  instance_type          = "t3.small"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  key_name               = "jenkins-slave"

  tags = {
    Name = "Jenkins-slave"
    Role = "slave"
  }
}

resource "aws_eip" "eip_master" {
  instance = aws_instance.jenkins_master.id

  tags = {
    Name = "eip-jenkins-master"
  }
}

resource "aws_eip" "eip_slave" {
  instance = aws_instance.jenkins_slave.id

  tags = {
    Name = "eip-jenkins-slave"
  }
}
