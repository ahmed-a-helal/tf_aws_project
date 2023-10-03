terraform {
  backend "s3" {
    
    bucket         = "tf.itilabs2"

    region         = "eu-central-1"

    encrypt        = true

    dynamodb_table = "terraform-state-lock-dynamo"

    key            = "tf.tfstate"

  }
}