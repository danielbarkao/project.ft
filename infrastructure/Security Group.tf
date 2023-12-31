

# Creating a security group named tutorial_jenkins_sg
# Remember, this security group is for our Jenkins EC2 instance
resource "aws_security_group" "jenkins_sg" {
  # Name, Description and the VPC of the Security Group
  name = "jenkins_sg"
  description = "Security group for jenkins server"
  vpc_id = aws_vpc.jenkins_vpc.id

  # Since Jenkins runs on port 8080, we are allowing all traffic from the internet
  # to be able ot access the EC2 instance on port 8080
  ingress {
    description = "Allow all traffic through port 8080"
    from_port = "8080"
    to_port = "8080"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Since we only want to be able to SSH into the Jenkins EC2 instance, we are only
  # allowing traffic from our IP on port 22
  ingress {
    description = "Allow SSH from my computer"
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound ICMP traffic
  ingress {
    from_port   = "-1"
    to_port     = "-1"
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # We want the Jenkins EC2 instance to being able to talk to the internet
  egress {
    description = "Allow all outbound traffic"
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

   # Allow outbound traffic (optional)



  # We are setting the Name tag to tutorial_jenkins_sg
  tags = {
    Name = "jenkins_sg"
  }
}
