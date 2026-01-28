# output - public ip 
output "ec2_public_ip" {
    value = aws_instance.bankapp_instance.public_ip
  
}