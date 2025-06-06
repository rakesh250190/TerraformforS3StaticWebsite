resource "aws_s3_bucket" "s3-bucket" {
  bucket = var.bucket_name
  tags = {
    name= "${var.bucket_name}"
  }
 
}

resource "aws_s3_bucket_versioning" "rg-bucket-webhosting-version" {
  bucket = aws_s3_bucket.s3-bucket.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_object" "index" {
    bucket = aws_s3_bucket.s3-bucket.bucket
    key = var.index_file
    source = var.index_file
    content_type = "text/html"
}

resource "aws_s3_object" "error" {
    
    bucket = aws_s3_bucket.s3-bucket.bucket
    key= var.error_file
    source = var.error_file
    content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "web-config" {
bucket = aws_s3_bucket.s3-bucket.bucket
index_document {
  suffix = "${var.index_file}" 
}  
error_document {
  key="${var.error_file}" 
}

}


resource "aws_s3_bucket_public_access_block" "public-acces" {

    bucket = aws_s3_bucket.s3-bucket.bucket

  
}

resource "aws_s3_bucket_policy" "bucket_policy" {
    bucket = aws_s3_bucket.s3-bucket.bucket
    policy = jsonencode(
        {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Statement1",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        
        "s3:GetObject"
      ],
      "Resource": [
       
        "arn:aws:s3:::${aws_s3_bucket.s3-bucket.bucket}/*"
      ]
    }
  ]
}
    )
depends_on = [ aws_s3_bucket_public_access_block.public-acces ]
}