resource "aws_s3_bucket" "site" {
  bucket = "levisegal-site-${terraform.env}"
  region = "${var.region}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "s3_site_bucket_policy",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::levisegal-site-${terraform.env}/*",
      "Principal": "*"
    }
  ]
}
POLICY

  website = {
    index_document = "index.html"
    error_document = "404.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "\/"
    },
    "Redirect": {
        "ReplaceKeyWith": "index.html"
    }
}]
EOF
  }

  logging = {
    target_bucket = "${aws_s3_bucket.site_log_bucket.id}"
    target_prefix = "log/"
  }

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket" "site_log_bucket" {
  bucket = "levisegal-site-logs-${terraform.env}"
  acl    = "log-delivery-write"
}

output "site_bucket_policy" {
  value = "${aws_s3_bucket.site.policy}"
}

output "site_bucket_arn" {
  value = "${aws_s3_bucket.site.arn}"
}

output "site_endpoint" {
  value = "http://${aws_s3_bucket.site.bucket}.s3-website-us-west-2.amazonaws.com/"
}
