# Jenkins Master
resource "aws_instance" "jenkins_master" {
  ami                    = "ami-0f58b397bc5c1f2e8" # Amazon Linux 2 for ap-south-1
  instance_type          = "t3.small"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.common.id, aws_security_group.jenkins.id]
  key_name               = "jenkins-master" # Ensure this key exists in EC2

  tags = {
    Name = "Jenkins-master"
    Role = "master"
  }
}

# Jenkins Slave
resource "aws_instance" "jenkins_slave" {
  ami                    = "ami-0f58b397bc5c1f2e8"
  instance_type          = "t3.small"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.common.id, aws_security_group.jenkins.id]
  key_name               = "jenkins-slave"

  tags = {
    Name = "Jenkins-slave"
    Role = "slave"
  }
}

# Elastic IPs
resource "aws_eip" "jenkins_master" {
  instance = aws_instance.jenkins_master.id

  tags = {
    Name = "eip-jenkins-master"
  }
}

resource "aws_eip" "jenkins_slave" {
  instance = aws_instance.jenkins_slave.id

  tags = {
    Name = "eip-jenkins-slave"
  }
}
