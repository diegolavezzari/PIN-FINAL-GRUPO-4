provider "aws" {
  region = "us-east-1" # Asegúrate de que la región sea us-east-1
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name # Nombre del bucket
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}