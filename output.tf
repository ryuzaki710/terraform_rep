output "my_console_output" {
  value = aws_instance.ec2_example.public_ip
  #sensitive = true
} 
