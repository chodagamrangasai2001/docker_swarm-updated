#Perform this lab as part of Docker Swarm Traefik Ingress Controller Lab.
resource "local_file" "docker-inventory-file" {
  content = templatefile("docker_details.tpl",
    {

      testserver01    = aws_instance.webservers.0.public_ip
      testserver02    = aws_instance.webservers.1.public_ip
      testserver03    = aws_instance.webservers.2.public_ip
      testserver04    = aws_instance.webservers.3.public_ip
      testserver05    = aws_instance.webservers.4.public_ip
      testserver06    = aws_instance.webservers.5.public_ip
    }
  )
  filename = "${path.module}/dockerinvfile"
}