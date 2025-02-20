resource "aws_instance" "monitoring" {
  ami                         = var.ami_id  # ID de la AMI
  instance_type               = var.instance_type               # Tipo de instancia EC2
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.subnet.id
  user_data                   = file("metrics.sh")  # Ejecutar el script al lanzar la instancia

  tags = {
    Name = var.instance_name
  }
}

# Habilitar versionado en el bucket
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Configurar cifrado del lado del servidor (SSE)
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}