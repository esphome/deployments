resource "aws_ecs_cluster" "svcs" {
  name = "ESPHome-Services"

  tags = {
    Region = var.region
  }
}