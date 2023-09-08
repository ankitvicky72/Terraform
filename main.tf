# Create an S3 bucket
resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucketname
  acl    = "private" # You can set this to "private" or "public-read" as needed
}

# Set bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.mybucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Configure public access block settings
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Set bucket ACL to public-read
resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.mybucket.id
  acl    = "public-read"
}

# Upload index.html object
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.mybucket.id
  key          = "index.html"
  source       = "index.html" # Make sure this file exists in the same directory as your Terraform files
  acl          = "public-read"
  content_type = "text/html"
}

# Upload error.html object
resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.mybucket.id
  key          = "error.html"
  source       = "error.html" # Make sure this file exists in the same directory as your Terraform files
  acl          = "public-read"
  content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.mybucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}