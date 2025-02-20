provider "aws" {
  region = var.region  # Usando la variable de región
}

terraform {
  backend "s3" {}
}
