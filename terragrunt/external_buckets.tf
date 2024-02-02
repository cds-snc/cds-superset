
data "aws_s3_bucket" "cur_data_extract" {
  bucket = "713f18dd-9f30-4976-a152-e81d48cf053a"
}

data "aws_s3_bucket" "tag_data_extract" {
  bucket = "5bf89a78-1503-4e02-9621-3ac658f558fb"
}