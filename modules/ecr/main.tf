resource "aws_ecr_repository" "app" {
  name = "sample-app"

  image_scanning_configuration {
    scan_on_push = true
  }
}