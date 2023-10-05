resource "aws_dynamodb_table" "backend" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20 
 tags = {
    project = "tf-iti-lab"
    creator = "Ahmed Attia"
 }
  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_s3_bucket" "backend" {
  bucket = "tf.itilabs2"

  tags = {
    type = "public"
    project = "tf-iti-lab"
    creator = "Ahmed Attia"
  }
}

resource "aws_s3_bucket_versioning" "itilabs" {
  bucket = aws_s3_bucket.backend.id

  versioning_configuration {
    status = "Enabled"
  }
}
